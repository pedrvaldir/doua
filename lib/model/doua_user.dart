
import 'package:firebase_auth/firebase_auth.dart';

class DouaUser {
  late String? name;
  late String? email;
  late String? photoUrl;
  late String? uid;
  DouaUser({this.name, this.email, this.photoUrl, this.uid});

  DouaUser.fromMap(Map<String, dynamic> map) {
    name = map['nome'];
    email = map['email'];
    photoUrl = map['urlFoto'];
    uid = map['token'];
  }

  factory DouaUser.fromSignAuthentication(User user) {
    return DouaUser(
      name: user.displayName,
      email: user.email,
      photoUrl: user.photoURL,
      uid: user.uid,
    );
  }
}
