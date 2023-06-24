import 'dart:async';

import 'package:doua/view/doua_dialog_add.dart';
import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'doua_list_card.dart';
import 'doua_onboarding_page.dart';

import 'package:doua/utils.dart';

import 'locals_page.dart';
import '../model/doua_acao.dart';
import '../viewmodel/home_viewmodel.dart';
import '../viewmodel/login_viewmodel.dart';
import '../viewmodel/search_viewmodel.dart';

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
    super.initState();
    Future.delayed(Duration.zero, () {
      this._loadList();
    });
  }

  _loadList() async {
    DouaDialogProgress.showLoading(context, false, "Carregando informações");
    await _loginViewModel.checkUserLogged();
    acoes = await _searchViewModel.getAcoes();
    Navigator.pop(context);
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
                child: GestureDetector(
                  onTap: () {
                    if (_loginViewModel.isLogged) {
                      Constants.TYPE_DONOR = true;
                      DouaDialogAcao.showInclude(context);
                    } else {
                      validateField();
                    }
                  },
                  child: DouaTagTitle(
                    title: Strings.TITLE_DONOR,
                    iconDoua: Icons.add,
                    isRight: true,
                  ),
                ),
              ),
              DouaListCard(
                  list:
                      acoes.reversed.where((i) => i.idTipoAcao == 2).toList()),
              DouaSpace.horizontalSpaceSmall,
              Padding(
                padding: const EdgeInsets.only(
                    left: DouaSizes.spacing20, right: DouaSizes.spacing20),
                child: GestureDetector(
                  onTap: () {
                    if (_loginViewModel.isLogged) {
                      Constants.TYPE_DONOR = false;
                      DouaDialogAcao.showInclude(context);
                    } else {
                      validateField();
                    }
                  },
                  child: DouaTagTitle(
                    title: Strings.TITLE_GRANTEES,
                    iconDoua: Icons.add,
                    isRight: true,
                  ),
                ),
              ),
              DouaListCard(
                  list:
                      acoes.reversed.where((i) => i.idTipoAcao != 2).toList()),
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
      return _loginViewModel.user.name.toString() + "\n";
    else
      return "";
  }

  validateField() {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Somente usuário logado pode incluir ação")));
  }
}
