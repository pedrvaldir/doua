import 'dart:async';

import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'doua_list_card.dart';
import 'doua_onboarding_page.dart';

import 'package:doua/utils.dart';

import 'locals_page.dart';
import 'model/doua_acao.dart';
import 'viewmodel/home_viewmodel.dart';
import 'viewmodel/login_viewmodel.dart';
import 'viewmodel/search_viewmodel.dart';

class SearchPage extends StatefulWidget {
  final String title;

  SearchPage(this.title) : super();

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = false;
  final _loginViewModel = LoginViewModel();
  final _searchViewModel = SearchViewModel();
  int _initialIndex = 0;
  List<DouaAcao> acoes = [];
  final List<Widget> _screens = [
    LocalsPage(),
  ];

  @override
  void initState() {
    _loadList();
    super.initState();
  }

  _loadList() async {
    await _loginViewModel.checkUserLogged();
    acoes = await _searchViewModel.getAcoes();
    if (mounted) setState(() {});
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
                child: DouaText.headingOne(getName() + Strings.WELCOME_MESSAGE),
              ),
              DouaSpace.horizontalSpaceSmall,
              Padding(
                padding: const EdgeInsets.only(
                    left: DouaSizes.spacing20, right: DouaSizes.spacing20),
                child: DouaTagTitle(
                  title: Strings.TITLE_DONOR,
                  iconDoua: Icons.add,
                  isRight: true,
                ),
              ),
              DouaListCard(
                  list: acoes.where((i) => i.idTipoAcao == 1).toList()),
              DouaSpace.horizontalSpaceSmall,
              Padding(
                padding: const EdgeInsets.only(
                    left: DouaSizes.spacing20, right: DouaSizes.spacing20),
                child: DouaTagTitle(
                  title: Strings.TITLE_GRANTEES,
                  iconDoua: Icons.add,
                  isRight: true,
                ),
              ),
              DouaListCard(
                  list: acoes.where((i) => i.idTipoAcao != 1).toList()),
            ],
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _initialIndex = index;
    });
  }

  getName() {
    if (_loginViewModel.isLogged && _loginViewModel.user.name != null)
      return _loginViewModel.user.name.toString() +"\n";
    else
      return "";
  }
}
