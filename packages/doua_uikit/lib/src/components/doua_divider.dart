import 'package:doua_uikit/src/shared/doua_pallet.dart';
import 'package:flutter/material.dart';

class DouaDivider extends StatelessWidget {
  Color? color;

  DouaDivider({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 8),
          child: Divider(
            height: 1,
            thickness: 2,
            indent: 4,
            endIndent: 4,
            color: color != null ? color : DouaPallet.kcSecondColor,
          ),
        ),
      ],
    );
  }
}
