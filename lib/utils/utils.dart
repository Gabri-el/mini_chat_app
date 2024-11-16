import 'package:flutter/material.dart';
import 'package:mini_chat_app/utils/snackBar.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String text, context, String type) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBarV2().showSnacks(text, type));
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   duration: Duration(seconds: 1),
    //   content: Text(text),
    // ));
    // if (text == null) return;

    // final snackBar = SnackBar(
    //     duration: Duration(seconds: 2),
    //     content: Text(text),
    //     backgroundColor: Colors.red);
    // messengerKey.currentState
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(snackBar);
  }
}
