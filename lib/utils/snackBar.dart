import 'package:flutter/material.dart';

class SnackBarV2 {
  SnackBar showSnacks(String snackMessage, String typeOfSnack) {
    Color checktypeOfSnacks() {
      switch (typeOfSnack) {
        case "success":
          return Color.fromARGB(255, 58, 182, 76);

        case "error":
          return Color.fromARGB(255, 205, 57, 57);

        case "warn":
          return Color.fromARGB(255, 246, 192, 44);

        case "wait":
          return Color.fromARGB(255, 44, 81, 246);

        default:
          return Color.fromARGB(255, 154, 154, 154);
      }
    }

    String checkTextOfSnacks() {
      switch (typeOfSnack) {
        case "success":
          return "Success";

        case "error":
          return "Error";

        case "warn":
          return "Warning";

        case "wait":
          return "Please wait....";

        default:
          return "Undefined";
      }
    }

    Icon checkIconOfSnacks() {
      switch (typeOfSnack) {
        case "success":
          return Icon(
            Icons.check,
            color: Colors.white,
          );

        case "error":
          return Icon(
            Icons.error,
            color: Colors.white,
          );

        case "warn":
          return Icon(
            Icons.warning,
            color: Colors.white,
          );

        default:
          return Icon(
            Icons.question_mark,
            color: Colors.white,
          );
      }
    }

    return SnackBar(
      duration: Duration(
          milliseconds:
              typeOfSnack == "error" || typeOfSnack == "warn" ? 4000 : 3000),
      padding: EdgeInsets.zero,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(color: checktypeOfSnacks()),
                child: checkIconOfSnacks(),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    checkTextOfSnacks(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 15,
                      color: checktypeOfSnacks(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    snackMessage,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF697178),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.white, //Color(0xFF3AB64D),
      behavior: SnackBarBehavior.floating,
    );
  }
}
