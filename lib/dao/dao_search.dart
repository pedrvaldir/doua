import 'package:doua/model/doua_acao.dart';

import '../Utils/constants.dart';
import '../Utils/doua_api_service.dart';
import '../Utils/exceptions.dart';
import '../api_response.dart';

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

  Future<ApiResponse> postAcoes(DouaAcao acao) async {
    Map<String, dynamic> json = handlerJson(acao);
    final chopper = DouaApiService.create();
    List<dynamic> result = [];

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

  Map<String, dynamic> handlerJson(DouaAcao acao) {
    return {
      "descricao": acao.descricao,
  "localizacao": {
    "latitude": acao.localizacao!.latitude,
    "longitude": acao.localizacao!.longitude
  },
  "qtdVotos": acao.qtdVotos,
  "tipoAcao": {
    "id": acao.idTipoAcao
  },
  "titulo": acao.titulo,
  "urlImg": acao.urlImg
    };
  }
}
