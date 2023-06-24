import 'package:doua/model/doua_acao.dart';

import '../Utils/constants.dart';
import '../Utils/doua_api_service.dart';
import '../Utils/exceptions.dart';
import '../api_response.dart';
import '../model/doua_user.dart';

class DaoSearch {
  Future<ApiResponse> getAcoes() async {
    final chopper = DouaApiService.create();
    List<dynamic> result = [];

    final respRetornlist =
        await chopper.getAcoes("authorization", EndPoints.getAcoes);

    if (respRetornlist.statusCode == 200 || respRetornlist.statusCode == 201)
      result = respRetornlist.body;
    else
      throwException(respRetornlist.error.toString());

    return ApiResponse(202, data: result);
  }

  Future<ApiResponse> getComentarios(String idAcao) async {
    final chopper = DouaApiService.create();
    List<dynamic> result = [];

    final respRetornlist = await chopper.getAcoes(
        "authorization", EndPoints.getComentario + idAcao);

    if (respRetornlist.statusCode == 200 || respRetornlist.statusCode == 201) {
      if (respRetornlist.bodyString != "{\"Erro\":\"Cliente nÃ£o encontrado\"}")
        result = respRetornlist.body;
    }

    // else
    // throwException(respRetornlist.error.toString());

    return ApiResponse(202, data: result);
  }

  Future<ApiResponse> postAcoes(DouaAcao acao) async {
    Map<String, dynamic> json = handlerJson(acao);
    final chopper = DouaApiService.create();
    List<dynamic> result = [];

    print(json.toString());

    final respRetornlist = await chopper.postAcoes(
      "authorization",
      json,
      EndPoints.getAcoes,
    );

    if (respRetornlist.statusCode == 200 || respRetornlist.statusCode == 201)
      result = respRetornlist.body;
    else
      throwException(respRetornlist.error.toString());

    return ApiResponse(202, data: result);
  }

  Future<ApiResponse> postComentario(
      String comentario, int acao, DouaUser user) async {
    final chopper = DouaApiService.create();
    List<dynamic> result = [];
    Map<String, dynamic> json = handlerJsonComentario(comentario, user);
    print("jsdon: $json");
    final respRetornlist = await chopper.postComentario("authorization", json,
        EndPoints.postComentario + acao.toString() + EndPoints.comentario);

    if (respRetornlist.statusCode != 200 && respRetornlist.statusCode != 201)
      throwException(respRetornlist.error.toString());

    return ApiResponse(202, data: result);
  }

  Map<String, dynamic> handlerJson(DouaAcao acao) {
    return {
      "descricao": acao.descricao,
      "localizacao": {
        "latitude": acao.localizacao!.latitude,
        "longitude": acao.localizacao!.longitude
      },
      "qtdVotos": acao.qtdVotos,
      "tipoAcao": {"id": acao.idTipoAcao},
      "titulo": acao.titulo,
      "urlImg": acao.urlImg
    };
  }

  Map<String, dynamic> handlerJsonComentario(String comentario, DouaUser user) {
    return {
      "descricao": comentario,
      "criador": {
        "nome": user.name,
        "email": user.email,
        "urlFoto": user.urlfoto
      }
    };
  }
}
