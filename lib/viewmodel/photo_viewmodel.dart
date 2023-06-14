import 'dart:async';
import 'dart:convert';

import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../Utils/exceptions.dart';
import '../dao/dao_home.dart';
import '../model/doua_user.dart';
import '../api_response.dart';
import '../dao/dao_login.dart';
import '../utils.dart';

class PhotoViewModel {
  final _streamController = StreamController<bool>.broadcast();
  late var user = DouaUser();
  late var isLogged = false;
  late List<TutorialSteps> tutorials = [];
  get stream => _streamController.stream;
  List<Asset> _resultList = [];
  String error = 'No Error Dectected';
  List<Asset> _images = [];
  var MAX_IMG = 1;

  Future<List<Asset>> catchPhoto(BuildContext context) async {
    _streamController.add(true);
    ApiResponse apiReponse;
    _resultList = [];
    try {
      _resultList = await MultiImagePicker.pickImages(
        maxImages: MAX_IMG,
        enableCamera: true,
        selectedAssets: _images,
        materialOptions: MaterialOptions(
          actionBarColor: "#0080ff",
          lightStatusBar: true,
          actionBarTitle: "DOUA",
          textOnNothingSelected: "Sem Imagem",
          selectionLimitReachedText: "Limite de 1 foto",
          allViewTitle: "Todas as fotos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception {
      apiReponse = ApiResponse(404);
    }

    _streamController.add(false);
    return _resultList;
  }
}
