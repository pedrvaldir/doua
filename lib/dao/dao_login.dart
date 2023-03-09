import 'package:doua/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api_response.dart';

class DaoLogin {
  late final GoogleSignInAccount? _googleUser;
  late final GoogleSignInAuthentication? _googleAuth;
  Future<UserCredential> signInWithGoogle() async {
    _googleUser = await GoogleSignIn().signIn();

    _googleAuth = await _googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: _googleAuth?.accessToken,
      idToken: _googleAuth?.idToken,
    );

    var result = await FirebaseAuth.instance.signInWithCredential(credential);

    return result;
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    try {
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      print(e);
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    }
  }

  Future<ApiResponse> signIn(SignWith sign) async {
    User response = await handleAutenticateResponse(sign);

    if (response.isAnonymous || response.displayName != null) {
      return ApiResponse(202, data: response);
    } else {
      return ApiResponse(response.hashCode, data: response.hashCode);
    }
  }

  Future<ApiResponse> signOut() async {
    var response = FacebookAuth.instance.logOut();
    return ApiResponse(202, data: response);
  }

  handleAutenticateResponse(SignWith sign) async {
    UserCredential response;
    switch (sign) {
      case SignWith.FACEBOOK:
        response = await signInWithFacebook();
        break;
      case SignWith.GOOGLE:
        response = await signInWithGoogle();
    }
    return response.user;
  }
}
