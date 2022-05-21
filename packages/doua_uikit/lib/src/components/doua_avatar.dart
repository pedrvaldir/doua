import 'package:doua_uikit/src/shared/doua_pallet.dart';
import 'package:flutter/material.dart';

class DouaAvatar extends StatelessWidget {
  String? url;
  double? value;

  DouaAvatar({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: value ?? 50, foregroundImage: NetworkImage(url ?? "https://www.monteirolobato.edu.br/public/assets/admin/images/avatars/avatar1.png"));
  }
}
