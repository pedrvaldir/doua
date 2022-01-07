import 'package:doua_uikit/doua_uikit.dart';
import 'package:doua_uikit/src/components/doua_divider.dart';
import 'package:flutter/material.dart';

class DouaTagTitle extends StatelessWidget {
  String? title;

  DouaTagTitle({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DouaDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DouaText.headline(title!.toUpperCase()),
            Icon(
              Icons.add,
              size: 40,
            ),
          ],
        ),
        DouaDivider(),
      ],
    );
  }
}
