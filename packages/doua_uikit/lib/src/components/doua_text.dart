import 'package:flutter/material.dart';
import 'package:doua_uikit/src/shared/styles.dart';
import 'package:doua_uikit/src/shared/doua_pallet.dart';
import '../../doua_uikit.dart';

class DouaText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const DouaText.headingOne(this.text) : style = heading1Style;
  const DouaText.headingTwo(this.text) : style = heading2Style;
  const DouaText.headingTitle(this.text) : style = headingTitle;
  const DouaText.headline(this.text) : style = headlineStyle;
  const DouaText.subheading(this.text) : style = subheadingStyle;
  const DouaText.caption(this.text) : style = captionStyle;

  DouaText.body(this.text, {Color color = DouaPallet.kcMediumGreyColor})
      : style = bodyStyle.copyWith(color: color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}