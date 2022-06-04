import 'package:firebase_auth/firebase_auth.dart';

class DouaUser {
  final String? name;
  final String? email;
  final String? photoUrl;
  DouaUser({this.name, this.email, this.photoUrl});

  factory DouaUser.fromSignAuthentication(User user) {
    return DouaUser(
      name: user.displayName,
      email: user.email,
      photoUrl: user.photoURL,
    );
  }
}
