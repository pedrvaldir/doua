import 'dart:async';
import 'dart:convert';

import 'package:doua_uikit/doua_uikit.dart';

import '../dao/dao_home.dart';
import '../dao/dao_search.dart';
import '../model/doua_acao.dart';
import '../model/doua_user.dart';
import '../api_response.dart';
import '../dao/dao_login.dart';
import '../utils.dart';
import 'home_viewmodel.dart';
import 'login_viewmodel.dart';

class SearchViewModel {
  final _streamController = StreamController<bool>.broadcast();
  late var isLogged = false;
  late List<DouaAcao> listAcoes = [];
  get stream => _streamController.stream;

  Future<List<DouaAcao>> getAcoes() async {
    _streamController.add(true);
    isLogged = true;
    ApiResponse apiReponse;
    try {
      apiReponse = await DaoSearch().getAcoes();

      if (apiReponse.data != null) {
        List<dynamic> data = apiReponse.data;

        for (Map map in data) {
          DouaAcao acao = DouaAcao.fromMap(map);
          listAcoes.add(acao);
        }

        return listAcoes;
      }
    } on Exception catch (e) {
      print(e);

      apiReponse = ApiResponse(404, error: "Exception");
    }
    isLogged = false;
    _streamController.add(false);
    return listAcoes;
  }
}
