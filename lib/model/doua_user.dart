
import 'package:firebase_auth/firebase_auth.dart';

class DouaUser {
  late String? name;
  late String? email;
  late String? urlfoto;
  late String? uid;
  DouaUser({this.name, this.email, this.urlfoto, this.uid});

  DouaUser.fromMap(Map<String, dynamic> map) {
    name = map['nome'];
    email = map['email'];
    urlfoto = map['urlFoto'];
    uid = map['token'];
  }

  factory DouaUser.fromSignAuthentication(User user) {
    return DouaUser(
      name: user.displayName,
      email: user.email,
      urlfoto: user.photoURL,
      uid: user.uid,
    );
  }
}
