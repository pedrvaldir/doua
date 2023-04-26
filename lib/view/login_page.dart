import 'dart:async';

import 'package:doua/Utils/prefs.dart';
import 'package:doua/utils.dart';
import 'package:doua_uikit/doua_uikit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/doua_user.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginViewModel = LoginViewModel();
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('  '),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            signIn(SignWith.FACEBOOK);
          },
          child: Container(
            height: 40,
            child: Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff1959a9),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5)),
                  ),
                  alignment: Alignment.center,
                  child: Text('F',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff2872ba),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        topRight: Radius.circular(5)),
                  ),
                  alignment: Alignment.center,
                  child: Text('Facebook',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ]),
          ),
        ),
        SizedBox(height: 20),
        StreamBuilder<bool>(
            stream: _loginViewModel.stream,
            initialData: false,
            builder: (context, snapshot) {
              return GestureDetector(
                onTap: () {
                  signIn(SignWith.GOOGLE);
                },
                child: Container(
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffdb4a39),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5)),
                          ),
                          alignment: Alignment.center,
                          child: Text('G',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffdb4a39),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5),
                                topRight: Radius.circular(5)),
                          ),
                          alignment: Alignment.center,
                          child: Text('Google',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }

  Widget _imgHeader() {
    return StreamBuilder<bool>(
        stream: _loginViewModel.stream,
        builder: (context, snapshot) {
          return DouaAvatar(url: _loginViewModel.user.photoUrl);
        });
  }

  Widget _title() {
    return StreamBuilder<bool>(
        stream: _loginViewModel.stream,
        builder: (context, snapshot) {
          if (_loginViewModel.isLogged) {
            return _credentials();
          } else {
            return _layoutDoua();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _loginViewModel.isLoading != true
          ? _body(height)
          : Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> signIn(SignWith opc) async {
    await _loginViewModel.signIn(opc);
  }

  Future<void> signOut() async {
    await _loginViewModel.signOut();
  }

  _signStruture() {
    return StreamBuilder<bool>(
        stream: _loginViewModel.stream,
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data == false) {
            return handleAuthenticate();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  _signOut() {
    return DouaButton.outline(
      title: 'Sair',
      onClick: () {
        signOut();
      },
    );
  }

  Widget handleAuthenticate() {
    if (_loginViewModel.isLogged) {
      return _listOptions();
    } else {
      return _facebookButton();
    }
  }

  _credentials() {
    return Column(
      children: [
        DouaText.headingOne(_loginViewModel.user.name!),
        SizedBox(height: 10),
        DouaText.body(_loginViewModel.user.email!),
        SizedBox(height: 20),
      ],
    );
  }

  _layoutDoua() {
    return Column(
      children: [
        RichText(
          text: new TextSpan(
            style: new TextStyle(
              fontSize: 40.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              new TextSpan(
                  text: 'Dou',
                  style: TextStyle(color: DouaPallet.kcMediumGreyColor)),
              new TextSpan(
                  text: 'A',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: DouaPallet.kcPrimaryColor)),
            ],
          ),
        ),
        _divider()
      ],
    );
  }

  Widget _listOptions() {
    return Column(
      children: [
        DouaTagTitle(
            title: "Informações", iconDoua: Icons.account_circle_rounded),
        DouaTagTitle(
            title: "Notificações", iconDoua: Icons.circle_notifications),
        DouaTagTitle(title: "Favoritos", iconDoua: Icons.favorite),
        DouaSpace.verticalSpaceSmall,
        _signOut(),
      ],
    );
  }

  _loadData() async {
    await _loginViewModel.checkUserLogged();
    prefs = await SharedPreferences.getInstance();
    if (mounted) setState(() {});
  }

  _body(double height) {
    return Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .05,
              right: -MediaQuery.of(context).size.width * .4,
              child: Text("data")),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .12),
                    _imgHeader(),
                    SizedBox(height: 20),
                    _title(),
                    SizedBox(height: 20),
                    _signStruture(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
