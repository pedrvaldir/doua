
import '../model/doua_localizacao.dart';

class DouaAcao {
  late String? titulo;
  late int? id;
  late String? urlImg;
  late String? descricao;
  late DouaLocalizacao? localizacao;
  late int? idTipoAcao;
  late int? qtdVotos;

  DouaAcao({this.id, this.titulo, this.urlImg, this.descricao, this.localizacao, this.idTipoAcao, this.qtdVotos});

   DouaAcao.fromMap(Map<dynamic, dynamic> map){
    id = map['id'];
    titulo = map['titulo'];
    urlImg = map['urlImg'];
    descricao = map['descricao'];
    localizacao = DouaLocalizacao.fromMap(map['localizacao']);
    idTipoAcao = map['tipoAcao']['id'];
    qtdVotos = map['qtdVotos'];
  }
}
