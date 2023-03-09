import 'package:doua_uikit/src/shared/doua_pallet.dart';
import 'package:flutter/material.dart';

class DouaImage extends StatelessWidget {
  String? url;
  double? height = 400;

  DouaImage({Key? key, this.url, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url!=null ? Image.network(url!, height: height,) : Image(image: AssetImage('assets/place-holder.png'), height: height,);
  }
}