
import 'package:firebase_auth/firebase_auth.dart';

class DouaUser {
  final String? name;
  final String? email;
  final String? photoUrl;
  final String? uid;
  DouaUser({this.name, this.email, this.photoUrl, this.uid});

  factory DouaUser.fromSignAuthentication(User user) {
    return DouaUser(
      name: user.displayName,
      email: user.email,
      photoUrl: user.photoURL,
      uid: user.uid,
    );
  }
}
