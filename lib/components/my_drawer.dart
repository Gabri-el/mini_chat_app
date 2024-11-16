import 'package:flutter/material.dart';
import 'package:mini_chat_app/auth/auth_service.dart';
import 'package:mini_chat_app/pages/setting_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // DrawHeader and more
            Column(
              children: [
                ///logo
                DrawerHeader(
                  child: Center(
                    child: Icon(Icons.message,
                        size: 40, color: Theme.of(context).colorScheme.primary),
                  ),
                ),

                //Home
                ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    //closes the drawer
                    Navigator.pop(context);
                  },
                ),

                //Setting
                ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    //closes the drawer
                    Navigator.pop(context);

                    //navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingPage(),
                      ),
                    );
                  },
                )
              ],
            ),
            //Logout
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ListTile(
                title: const Text("L O G O U T"),
                leading: const Icon(Icons.settings),
                onTap: () async {
                  //closes the drawer
                  Navigator.pop(context);

                  //sign out the user
                  await AuthService.signout();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
