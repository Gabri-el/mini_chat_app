import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_chat_app/models/message.dart';

class ChatService {
  //instances
  FirebaseFirestore database = FirebaseFirestore.instance;

  ///stream of users
  Stream<List<Map<String, dynamic>>> users() {
    return database.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //chat
  Future<void> sendMessage(String receiverId, String message) async {
    //details for sending the messgae
    final String currentuserUid = await FirebaseAuth.instance.currentUser!.uid;
    final String currentUserEmail =
        await FirebaseAuth.instance.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a message
    Message newMessage = Message(
        senderEmail: currentUserEmail,
        senderId: currentuserUid,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    //create a unigue chatroom
    List ids = [currentuserUid, receiverId];
    ids.sort();
    String chatroomId = ids.join("_");
    await FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(senderId, receiverId) {
    List ids = [senderId, receiverId];
    ids.sort();
    String chatroomsId = ids.join("_");

    return FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatroomsId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Stream<List<Map<String, dynamic>>> getMyMessages(senderId, receiverId) {
    List ids = [senderId, receiverId];
    ids.sort();
    String chatroomsId = ids.join("_");

    return FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatroomsId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final message = doc.data();
        return message;
      }).toList();
    });
  }
}
