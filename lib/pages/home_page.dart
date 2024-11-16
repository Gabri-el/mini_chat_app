import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_chat_app/auth/auth_service.dart';
import 'package:mini_chat_app/chat/chat_service.dart';
import 'package:mini_chat_app/components/my_drawer.dart';
import 'package:mini_chat_app/components/user_tile.dart';
import 'package:mini_chat_app/pages/chatting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ChatService chatService = ChatService();
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: StreamBuilder(
        stream: chatService.users(),
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
            debugPrint("print user data ${snapshot.data}");
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = snapshot.data[index];
                  if (data["email"] ==
                      FirebaseAuth.instance.currentUser!.email) {
                    return Container();
                  } else {
                    return UserTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChattingPage(
                              username: data["email"],
                              receiverId: data["uid"],
                            ),
                          ),
                        );
                      },
                      text: data["email"] ?? "loadiing",
                    );
                  }
                });
          }
          return const Text("Move it");
        },
      ),
      drawer: const MyDrawer(),
    );
  }
}
