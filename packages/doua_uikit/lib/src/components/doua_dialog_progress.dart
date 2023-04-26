import 'package:doua_uikit/src/shared/doua_pallet.dart';
import 'package:flutter/material.dart';

class DouaDialogProgress {
  static Future<void> showLoading(
      BuildContext context, bool loading, String msg) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: DouaPallet.kcLightGreyColor,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          msg,
                          style: TextStyle(color: DouaPallet.kcPrimaryColor),
                        )
                      ]),
                    )
                  ]));
        });
  }
}