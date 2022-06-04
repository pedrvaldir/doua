import 'dart:async';

import '../model/doua_user.dart';
import '../api_response.dart';
import '../dao/dao_login.dart';
import '../utils.dart';

class LoginViewModel {
  final _streamController = StreamController<bool>.broadcast();
  late var user = DouaUser();
  late var isLogged = false;
  get stream => _streamController.stream;

  Future<ApiResponse> signIn(SignWith opc) async {
    _streamController.add(true);
    ApiResponse apiReponse;
    try {
      apiReponse = await DaoLogin().signIn(opc);
      user = DouaUser.fromSignAuthentication(apiReponse.data);
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
}
