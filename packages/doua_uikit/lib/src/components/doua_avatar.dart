import 'package:doua_uikit/src/shared/doua_pallet.dart';
import 'package:flutter/material.dart';

class DouaAvatar extends StatelessWidget {
  String? url;
  double? value;

  DouaAvatar({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: value ?? 50, foregroundImage: url==null ? AssetImage('assets/place-holder.png') as ImageProvider : NetworkImage(url!), );
  }
}