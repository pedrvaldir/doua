import 'dart:async';

import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';
import 'doua_onboarding_page.dart';

import 'package:doua/utils.dart';

import 'locals_page.dart';

class SearchPage extends StatefulWidget {
  final String title;

  SearchPage(this.title) : super();

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  int _initialIndex = 0;
  final List<Widget> _screens = [
    LocalsPage(),
  ];

  @override
  void initState() {
    _showOnboarding();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Column(
            children: [
              DouaHeader(),
              DouaSpace.horizontalSpaceSmall,
              Center(
                child: DouaText.headingOne(Strings.WELCOME_MESSAGE),
              ),
              DouaSpace.horizontalSpaceSmall,
              Padding(
                padding: const EdgeInsets.only(
                    left: DouaSizes.spacing20, right: DouaSizes.spacing20),
                child: DouaTagTitle(title: Strings.TITLE_DONOR),
              ),
              DouaListCard(list: _listCards()),
              DouaSpace.horizontalSpaceSmall,
              Padding(
                padding: const EdgeInsets.only(
                    left: DouaSizes.spacing20, right: DouaSizes.spacing20),
                child: DouaTagTitle(title: Strings.TITLE_GRANTEES),
              ),
              DouaListCard(list: _listCards()),
            ],
          ),
        ),
      ),
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

}



_listCards() {
  return [
    DouaCard(title: "Roupas de frio", pathImg: 'assets/place-holder.png'),
    DouaCard(title: "Prateleira", pathImg: 'assets/place-holder.png'),
    DouaCard(title: "Porta", pathImg: 'assets/place-holder.png'),
    DouaCard(title: "Roupas de frio", pathImg: 'assets/place-holder.png'),
    DouaCard(title: "Maquina de lavar", pathImg: 'assets/place-holder.png'),
  ];
}
