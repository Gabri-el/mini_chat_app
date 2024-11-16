import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserTile extends StatefulWidget {
  UserTile({super.key, required this.onTap, required this.text});
  final void Function()? onTap;
  final String text;

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25.0,
          top: 10,
          bottom: 10,
        ),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  const Icon(Icons.person),
                  const SizedBox(width: 20),
                  Text(widget.text),
                ],
              ),
            )),
      ),
    );
  }
}
