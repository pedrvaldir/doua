import 'package:doua_uikit/doua_uikit.dart';
import 'package:doua_uikit/src/components/doua_divider.dart';
import 'package:flutter/material.dart';

class DouaTagTitle extends StatelessWidget {
  String? title;
  IconData? iconDoua;
  bool? isRight;

  DouaTagTitle({Key? key, this.title, this.iconDoua, this.isRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DouaDivider(),
        Row(
          mainAxisAlignment: isRight == true
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isRight != true && iconDoua != null)
              Icon(
                iconDoua,
                size: 40,
                color: DouaPallet.kcMediumGreyColor,
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DouaText.headingTitle(title!.toUpperCase()),
            ),
            if (isRight == true && iconDoua != null)
              Icon(
                iconDoua,
                size: 40,
                color: DouaPallet.kcMediumGreyColor,
              ),
          ],
        ),
        DouaDivider(),
      ],
    );
  }
}
