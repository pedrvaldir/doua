import 'package:doua/model/doua_user.dart';

class DouaComentario {
  int? id;
  String? descricao;
  DouaUser? criador;

  DouaComentario({this.id, this.descricao, this.criador});

  DouaComentario.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    descricao = map['descricao'];
    criador = DouaUser.fromMap(map['criador']);
  }
}
