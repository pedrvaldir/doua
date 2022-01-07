import 'package:flutter/material.dart';

class DouaHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? text;

  DouaHeader({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Icon(
        Icons.account_circle_rounded,
        color: Colors.black54,
      ),
      leadingWidth: 65,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            Icons.more_vert,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
