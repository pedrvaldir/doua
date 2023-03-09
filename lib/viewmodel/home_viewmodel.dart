import 'dart:async';
import 'dart:convert';

import 'package:doua_uikit/doua_uikit.dart';

import '../Utils/exceptions.dart';
import '../dao/dao_home.dart';
import '../model/doua_user.dart';
import '../api_response.dart';
import '../dao/dao_login.dart';
import '../utils.dart';

class HomeViewModel {
  final _streamController = StreamController<bool>.broadcast();
  late var user = DouaUser();
  late var isLogged = false;
  late List<TutorialSteps> tutorials = [];
  get stream => _streamController.stream;

  Future<List<TutorialSteps>> getOnboarding() async {
    _streamController.add(true);
    ApiResponse apiReponse;
    try {
      apiReponse = await DaoHome().getOnboarding();

      if (apiReponse.data != null) {
       List<dynamic> result = apiReponse.data;

        List<TutorialSteps> tutorials = [];

        for (Map map in result) {
          TutorialSteps tutorial = TutorialSteps.fromMap(map);
          tutorials.add(tutorial);
        }

        return tutorials;
      }
    } on Exception {
      apiReponse = ApiResponse(404);
    }

    _streamController.add(false);
    return tutorials;
  }
}
