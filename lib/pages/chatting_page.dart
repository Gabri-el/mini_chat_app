import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_chat_app/auth/auth_service.dart';
import 'package:mini_chat_app/chat/chat_service.dart';
import 'package:mini_chat_app/components/my_textfield.dart';
import 'package:mini_chat_app/components/user_tile.dart';

class ChattingPage extends StatefulWidget {
  ChattingPage({super.key, required this.username, required this.receiverId});
  final String username;
  final String receiverId;

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  //TextEditing Controller
  TextEditingController messageController = TextEditingController();

  //chat service
  ChatService chatService = ChatService();
  AuthService authService = AuthService();

  //send message
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      debugPrint("send message ${widget.receiverId}");
      await chatService.sendMessage(widget.receiverId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.username),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: chatService.getMyMessages(
                  FirebaseAuth.instance.currentUser!.uid, widget.receiverId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  debugPrint("users error ${snapshot.error}");
                  return const Center(
                    child: Text("An error occured"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("No User found")],
                    ),
                  );
                }
                if (snapshot.hasData) {
                  debugPrint("print message  data ${snapshot.data.toString()}");
                  //final document = snapshot.data.docs;
                  // return ListView(
                  //     children: document.map<Widget>((doc) {
                  //   return Text("helllooooo");
                  // }).toList());

                  if (snapshot.data.toString().isEmpty) {
                    return Text("Hello");
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = snapshot.data[index];
                          //debugPrint("message $data");
                          bool currentUserMessage =
                              data["sendId"] == authService.currentUsert();
                          debugPrint(
                              "ch ${data["sendId"]} and curent ${authService.currentUsert()}");
                          var alignment = currentUserMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft;
                          return Container(
                            alignment: alignment,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                children: [
                                  Text(data["message"]),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }
                return const Text("Move it");
              },
            ),
          ),
          Row(children: [
            Expanded(
                child: MyTextfield(
              controller: messageController,
              hintText: 'Type your message',
              obscureText: false,
            )),
            IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward))
          ])
        ],
      ),
    );
  }
}
