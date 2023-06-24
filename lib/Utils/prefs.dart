import 'package:shared_preferences/shared_preferences.dart';

import '../model/doua_user.dart';
import '../model/user.dart';

class Prefs {
  Future<String> getAuthorization() async {
    var result = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Return String
    if (prefs.getString('uid') != null)
      result = "Bearer " + prefs.getString('uid')!;

    return result;
  }

  readOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('onboarding', "true");
  }

  getOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("onboarding") != "true"){
      return false;
    }else{
      return true;
    }
  }

  writeNameAndUser(DouaUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('name', user.name.toString());
    prefs.setString('email', user.email.toString());
    prefs.setString('urlfoto', user.urlfoto.toString());
  }

  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("Name");
  }

  getRemove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("urlfoto");
  }

  isUserLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Return String
    return prefs.getString('name') != null;
  }

  Future<DouaUser> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return DouaUser(
        name: prefs.getString('name'),
        email: prefs.getString('email'),
//        uid: prefs.getString('uid'),
        urlfoto: prefs.getString('urlfoto'));
  }

  // rememberUser(String pass, String mail) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   prefs.setString('password', pass);
  //   prefs.setString('email', mail);
  // }
}
