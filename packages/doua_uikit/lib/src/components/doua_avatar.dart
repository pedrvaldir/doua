import 'package:doua_uikit/src/shared/doua_pallet.dart';
import 'package:flutter/material.dart';

class DouaAvatar extends StatelessWidget {
  String? url;
  double? value;

  DouaAvatar({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: value ?? 30,
        foregroundImage: url == null
            ? AssetImage('assets/place-holder.png') as ImageProvider
            : NetworkImage(url!, scale: 0.001),
      ),
    );
  }
}
