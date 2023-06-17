import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';

import 'view/doua_list_card.dart';
import 'view/doua_onboarding_page.dart';
import 'model/doua_acao.dart';
import 'model/doua_localizacao.dart';

class ShowCaseInitialPage extends StatefulWidget {
  final String title;

  ShowCaseInitialPage(this.title) : super();

  @override
  _ShowCaseInitialPageState createState() => _ShowCaseInitialPageState();
}

class _ShowCaseInitialPageState extends State<ShowCaseInitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DouaHeader(text: widget.title),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        children: [
          DouaText.headingOne('DOUA design'),
          vertical_space_small(),
          Divider(),
          vertical_space_small(),
          modalBottomSheet(context),
          ...buttonWidgets(context),
          ...textWidgets,
          ...inputFields,
        ],
      ),
    );
  }
}

Widget modalBottomSheet(BuildContext context) {
  return Text("");
}

Widget vertical_space_small() {
  return SizedBox(height: DouaSizes.spacingStack15);
}

Widget verticalSpaceMedium() {
  return SizedBox(height: DouaSizes.spacingStack15);
}

List<Widget> get textWidgets => [
      DouaText.headline('Estilo do textos'),
      verticalSpaceMedium(),
      DouaText.headingOne('Titulo 1'),
      verticalSpaceMedium(),
      DouaText.headingTwo('Titulo 2'),
      verticalSpaceMedium(),
      DouaText.headingTitle('Subtitulo'),
      verticalSpaceMedium(),
      DouaText.headline('cabeçalho'),
      verticalSpaceMedium(),
      DouaText.subheading('texto para cabeçalho'),
      verticalSpaceMedium(),
      DouaText.body('Corpo do texto em geral'),
      verticalSpaceMedium(),
      DouaText.caption('Texto em caixa alta'),
      verticalSpaceMedium(),
    ];

List<Widget> buttonWidgets(var context) => [
      DouaTagTitle(title: "TITULO TAG"),
      DouaText.body('lista de Cards'),
      DouaTagTitle(title: "ICONE E TITULO", iconDoua: Icons.add),
      DouaText.body('List Cards'),
      DouaListCard(list: _listCards()),
      DouaText.headline('Botões'),
      verticalSpaceMedium(),
      DouaText.body('Normal'),
      vertical_space_small(),
      DouaButton(
        title: 'TUTORIAL',
        onClick: () {
          //DouaOnboading(context, ).show(context);
        },
      ),
      vertical_space_small(),
      DouaText.body('Desativado'),
      vertical_space_small(),
      DouaButton(
        title: 'Logar',
        disabled: true,
        onClick: () {},
      ),
      vertical_space_small(),
      DouaText.body('Loading'),
      vertical_space_small(),
      DouaButton(
        title: 'Entrar',
        busy: true,
        onClick: () {},
      ),
      vertical_space_small(),
      DouaText.body('Outline'),
      vertical_space_small(),
      DouaButton.outline(
        title: 'Botao com íconeç',
        leading: Icon(
          Icons.send,
          color: DouaPallet.kcPrimaryColor,
        ),
        onClick: () {},
      ),
      vertical_space_small(),
    ];

_listCards() {
  List<DouaAcao> acoes = [
    DouaAcao(
        titulo: "titulo 1",
        id: 2,
        descricao: "",
        localizacao: DouaLocalizacao(id: 1, latitude: 1.00, longitude: 2.00),
        idTipoAcao: 1,
        qtdVotos: 2),
    DouaAcao(
        titulo: "titulo 2",
        id: 2,
        descricao: "",
        localizacao: DouaLocalizacao(id: 1, latitude: 1.00, longitude: 2.00),
        idTipoAcao: 1,
        qtdVotos: 2)
  ];

  return acoes;
}

List<Widget> get inputFields => [
      DouaText.headline('Campo de texto'),
      vertical_space_small(),
      DouaText.body('Normal'),
      vertical_space_small(),
      DouaInputField(
        controller: TextEditingController(),
        placeholder: 'Senha',
      ),
      vertical_space_small(),
      DouaText.body('Icone esquerda'),
      vertical_space_small(),
      DouaInputField(
        controller: TextEditingController(),
        leading: Icon(Icons.reset_tv),
        placeholder: 'Text',
      ),
      vertical_space_small(),
      DouaText.body('Icone a direita'),
      vertical_space_small(),
      DouaInputField(
        controller: TextEditingController(),
        trailing: Icon(Icons.clear_outlined),
        placeholder: 'Pesquisa',
      ),
    ];
