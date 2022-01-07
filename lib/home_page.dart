import 'dart:async';

import 'package:doua/search_page.dart';
import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'doua_onboarding_page.dart';
import 'locals_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage(this.title) : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _initialIndex = 0;
  final List<Widget> _screens = [
    SearchPage("Search"),
    LocalsPage(),
    LoginPage(),
  ];

  @override
  void initState() {
    _showOnboarding();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: _body(),
      body: _screens[_initialIndex],
      bottomNavigationBar: _bottomNavigatorCustom()
    );
  }

  void _showOnboarding() {
    Timer(Duration(seconds: 1), () {
      setState(() {
        DouaOnboading(context).show(context);
      });
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
}
