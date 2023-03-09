import 'dart:async';

import 'package:doua/model/doua_user.dart';

import '../Utils/constants.dart';
import '../Utils/prefs.dart';
import '../api_response.dart';
import '../dao/dao_login.dart';

import '../utils.dart';

class LoginViewModel {
  final _streamController = StreamController<bool>.broadcast();
  late var user = DouaUser();
  late var isLogged = false;
  late var isLoading = false;
  get stream => _streamController.stream;

  Future<ApiResponse> signIn(SignWith opc) async {
    _streamController.add(true);
    ApiResponse apiReponse;
    try {
      apiReponse = await DaoLogin().signIn(opc);
      user = DouaUser.fromSignAuthentication(apiReponse.data);
      await addDataPref(user);
      isLogged = true;
    } on Exception catch (_) {
      apiReponse = ApiResponse(404, error: "Exception");
    }

    _streamController.add(false);
    return apiReponse;
  }

  Future<ApiResponse> signOut() async {
    _streamController.add(true);
    ApiResponse apiReponse;
    try {
      apiReponse = await DaoLogin().signOut();
      user = DouaUser();
      isLogged = false;
    } on Exception catch (_) {
      apiReponse = ApiResponse(404, error: "Exception");
    }

    _streamController.add(false);
    return apiReponse;
  }

  addDataPref(DouaUser user) async {
    Prefs().writeNameAndUser(user);
  }

  checkUserLogged() async {
    isLoading = true;
    isLogged = await Prefs().isUserLogged();
    if (isLogged) user = await Prefs().getUser();
    isLoading = false;
  }
}
