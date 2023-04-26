import 'package:doua/utils.dart';
import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';

import 'doua_add_acao.dart';

class DouaDialogAcao {
  final TextEditingController descriptionController = TextEditingController();

  static showInclude(context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    _close(context),
                    _header(setState),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onChanged: (value) => {
                        Constants.DESCRIPTION = value,
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: Constants.TYPE_DONOR
                              ? 'O que você está doando?'
                              : 'O que você deseja receber?'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _button(context),
                  ]),
                ),
              ),
            );
          });
        });
  }

  static _header(StateSetter setState) {
    print(Constants.TYPE_DONOR);
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                child: GestureDetector(
              onTap: () {
                Constants.TYPE_DONOR = true;
                setState(() {});
              },
              child: CircleAvatar(
                backgroundColor: Constants.TYPE_DONOR
                    ? DouaPallet.kcPrimaryColor
                    : Colors.white,
                radius: 40,
                child: Center(
                    child: Text(
                  ":) \n Doar",
                  textAlign: TextAlign.center,
                )),
              ),
            )),
          ),
          Expanded(
            flex: 1,
            child: Container(
                child: GestureDetector(
              onTap: () {
                Constants.TYPE_DONOR = false;
                setState(() {});
              },
              child: CircleAvatar(
                backgroundColor: !Constants.TYPE_DONOR
                    ? DouaPallet.kcPrimaryColor
                    : Colors.white,
                radius: 40,
                child: Center(
                    child: Text(
                  "(: \n Receber",
                  textAlign: TextAlign.center,
                )),
              ),
            )),
          ),
        ],
      ),
    );
  }

  static _close(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Constants.DESCRIPTION = "";
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  static _button(BuildContext context) {
    return TextButton(
        onPressed: () {
          print('Clicked');
          Navigator.pop(context);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DouaAddAcaoPage()));
        },
        child: Text("continuar"));
  }

  static buttonPressed(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DouaAddAcaoPage()));
  }
}
