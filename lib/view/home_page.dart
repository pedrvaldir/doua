import 'dart:async';

import 'package:doua/Utils/prefs.dart';
import 'package:doua/api_response.dart';
import 'package:doua/view/search_page.dart';
import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'doua_onboarding_page.dart';
import 'locals_page.dart';
import 'login_page.dart';
import '../viewmodel/home_viewmodel.dart';
import '../viewmodel/login_viewmodel.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage(this.title) : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _loginViewModel = LoginViewModel();
  final _homeViewModel = HomeViewModel();
  bool isLoading = false;
  int _initialIndex = 0;
  final List<Widget> _screens = [
    SearchPage("Search"),
    LocalsPage(),
    LoginPage(),
  ];

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //body: _body(),
        body: isLoading ? _buildLoading : _screens[_initialIndex],
        bottomNavigationBar: _bottomNavigatorCustom());
  }

  void _checkOnboarding() async {
    isLoading = true;
    await getOnboarding();
    setState(() {
      isLoading = false;
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _initialIndex = index;
    });
  }

  _bottomNavigatorCustom() {
    return BottomNavigationBar(
      backgroundColor: DouaPallet.kcLightGreyColor,
      currentIndex: _initialIndex,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Icon(
                    Icons.search,
                    color: DouaPallet.kcPrimaryColor,
                  ),
                ],
              ),
            ),
            label: "Buscar"),
        BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(
                  Icons.place,
                  color: DouaPallet.kcPrimaryColor,
                ),
              ],
            ),
            label: "Locais"),
        BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(
                  Icons.account_circle,
                  color: DouaPallet.kcPrimaryColor,
                ),
              ],
            ),
            label: "Usuário"),
      ],
    );
  }

  Future<void> getOnboarding() async {
    if (!_loginViewModel.isLogged) {
      List<TutorialSteps> onboarding = await _homeViewModel.getOnboarding();
      bool viewOnboarding = await Prefs().getOnboarding();
      if (!onboarding.isEmpty && !viewOnboarding) {
        Prefs().readOnboarding();
        DouaOnboading(context, onboarding).show(context);
      }
    }
  }

  Center get _buildLoading {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Future<void> _loadData() async {
    _loginViewModel.checkUserLogged();
    if (!_loginViewModel.isLogged) _checkOnboarding();
  }
}
