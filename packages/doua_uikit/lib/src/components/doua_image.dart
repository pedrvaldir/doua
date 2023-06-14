import 'dart:typed_data';
import 'dart:convert';
import 'package:doua_uikit/src/shared/doua_pallet.dart';
import 'package:flutter/material.dart';

class DouaImage extends StatelessWidget {
  String? url;
  String? base64;
  double? height = 300;

  DouaImage({Key? key, this.url, this.base64, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url == null && base64 == null
        ? Image(
            image: AssetImage('assets/place-holder.png'),
            height: height,
          )
        : loadImage();
  }

  loadImage() {
    if (url != null) {
      return Image.network(
        url!,
        height: height,
      );
    } else {
      Uint8List bytes = Base64Decoder().convert(base64!);
      return Image.memory(
        bytes,
        height: height,
      );
    }
  }
}
