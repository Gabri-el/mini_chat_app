import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyButon extends StatelessWidget {
  MyButon({super.key, required this.text, required this.onTap});
  final String text;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
