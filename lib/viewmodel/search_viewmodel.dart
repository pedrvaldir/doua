import 'dart:async';
import 'dart:convert';

import 'package:doua_uikit/doua_uikit.dart';

import '../dao/dao_home.dart';
import '../dao/dao_search.dart';
import '../model/doua_acao.dart';
import '../model/doua_comentario.dart';
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
  late List<DouaComentario> listComentarios = [];
  get stream => _streamController.stream;

  Future<List<DouaAcao>> getAcoes() async {
    _streamController.add(true);
    isLogged = true;
    ApiResponse apiReponse;
    try {
      apiReponse = await DaoSearch().getAcoes();

      if (apiReponse.data != null) {
        listAcoes = [];
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

  Future<List<DouaComentario>> getComentarios(String idAcao) async {
    _streamController.add(true);
    isLogged = true;
    ApiResponse apiReponse;
    try {
      apiReponse = await DaoSearch().getComentarios(idAcao);
      listComentarios = [];
      if (apiReponse.data != null) {
        listAcoes = [];
        List<dynamic> data = apiReponse.data;

        for (Map map in data) {
          DouaComentario comentario = DouaComentario.fromMap(map);
          listComentarios.add(comentario);
        }

        return listComentarios;
      }
    } on Exception catch (e) {
      print(e);

      apiReponse = ApiResponse(404, error: "Exception");
    }
    isLogged = false;
    _streamController.add(false);
    return listComentarios;
  }

  Future<List<DouaAcao>> postAcao(DouaAcao acao) async {
    _streamController.add(true);
    isLogged = true;
    ApiResponse apiReponse;
    print("Foto: " + acao.urlImg.toString());
    try {
      apiReponse = await DaoSearch().postAcoes(acao);

      if (apiReponse.data != null) {
        List<dynamic> data = apiReponse.data;

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

  Future<bool> postComentario(String comentario, int acao) async {
    _streamController.add(true);
    isLogged = true;
    ApiResponse apiReponse;
    try {
      apiReponse = await DaoSearch().postComentario(comentario, acao);

      if (apiReponse.statusCode == 200 || apiReponse.statusCode == 202) {
        return true;
      }
    } on Exception catch (e) {
      print(e);

      apiReponse = ApiResponse(404, error: "Exception");
      return false;
    }
    isLogged = false;
    _streamController.add(false);
    return true;
  }
}
