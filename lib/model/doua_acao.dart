import 'package:doua/model/doua_comentario.dart';
import 'package:doua/model/doua_user.dart';

import '../model/doua_localizacao.dart';

class DouaAcao {
  late String? titulo;
  late int? id;
  late String? urlImg;
  late String? descricao;
  late DouaLocalizacao? localizacao;
  late int? idTipoAcao;
  late int? qtdVotos;
  late List<DouaComentario>? comentarios;

  DouaAcao(
      {this.id,
      this.titulo,
      this.urlImg,
      this.descricao,
      this.localizacao,
      this.idTipoAcao,
      this.qtdVotos,
      this.comentarios});

  DouaAcao.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    titulo = map['titulo'];
    urlImg = map['urlImg'];
    descricao = map['descricao'];
    localizacao = DouaLocalizacao.fromMap(map['localizacao']);
    idTipoAcao = map['tipoAcao']['id'];
    comentarios = handleListComentarios(map['comentarios']);
    qtdVotos = map['qtdVotos'];
  }

  Map<String, dynamic> toPutMapServidor() {
    return {
      'titulo': titulo,
      'urlImg': urlImg,
      'descricao': descricao,
      'tipoAcao': '{id:$idTipoAcao}',
      'localizacao': localizacao?.toPutMapServidor(),
      'qtdVotos': qtdVotos,
    };
  }
}

List<DouaComentario>? handleListComentarios(list) {
  List<DouaComentario> result = [];

  for (final index in list) {
    result.add(DouaComentario.fromMap(index));
  }

  return result;
}
