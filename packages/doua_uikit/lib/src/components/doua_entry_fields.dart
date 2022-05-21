
import 'package:flutter/material.dart';

class DouaEntryFields extends StatelessWidget {
  final String? title;
  final bool isPassword;
  final void Function()? onTap;
  final bool outline;
  final Widget? leading;

  const DouaEntryFields({
    Key? key,
    required this.title,
    this.isPassword = false,
    this.onTap,
    this.leading,
  })  : outline = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  hintText: title,
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }
}