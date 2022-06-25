import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';

import 'doua_onboarding_page.dart';

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
          DouaText.headingOne('Show Case'),
          vertical_space_small(),
          Divider(),
          vertical_space_small(),
          ...buttonWidgets(context),
          ...textWidgets,
          ...inputFields,
        ],
      ),
    );
  }
}

Widget vertical_space_small() {
  return SizedBox(height: DouaSizes.spacingStack15);
}

Widget verticalSpaceMedium() {
  return SizedBox(height: DouaSizes.spacingStack15);
}

List<Widget> get textWidgets => [
      DouaText.headline('Text Styles'),
      verticalSpaceMedium(),
      DouaText.headingOne('Heading One'),
      verticalSpaceMedium(),
      DouaText.headingTwo('Heading Two'),
      verticalSpaceMedium(),
      DouaText.headingThree('Heading Three'),
      verticalSpaceMedium(),
      DouaText.headline('Headline'),
      verticalSpaceMedium(),
      DouaText.subheading('This will be a sub heading to the headling'),
      verticalSpaceMedium(),
      DouaText.body('Body Text that will be used for the general body'),
      verticalSpaceMedium(),
      DouaText.caption('This will be the caption usually for smaller details'),
      verticalSpaceMedium(),
    ];

List<Widget> buttonWidgets(var context) => [
      DouaTagTitle(title: "TAG TITLE"),
      DouaText.body('List Cards'),
      DouaTagTitle(title: "TAG Custom", iconDoua: Icons.add),
      DouaText.body('List Cards'),
      DouaListCard(list: _listCards()),
      DouaText.headline('Buttons'),
      verticalSpaceMedium(),
      DouaText.body('Normal'),
      vertical_space_small(),
      DouaButton(
        title: 'TUTORIAL',
        onClick: () {
          DouaOnboading(context).show(context);
        },
      ),
      vertical_space_small(),
      DouaText.body('Disabled'),
      vertical_space_small(),
      DouaButton(
        title: 'SIGN IN',
        disabled: true,
        onClick: () {},
      ),
      vertical_space_small(),
      DouaText.body('Busy'),
      vertical_space_small(),
      DouaButton(
        title: 'SIGN IN',
        busy: true,
        onClick: () {},
      ),
      vertical_space_small(),
      DouaText.body('Outline'),
      vertical_space_small(),
      DouaButton.outline(
        title: 'Select location',
        leading: Icon(
          Icons.send,
          color: DouaPallet.kcPrimaryColor,
        ),
        onClick: () {},
      ),
      vertical_space_small(),
    ];

_listCards() {
  return [
    DouaCard(title: "Roupas de frio", pathImg: 'assets/place-holder.png'),
    DouaCard(title: "Prateleira", pathImg: 'assets/place-holder.png'),
    DouaCard(title: "Porta", pathImg: 'assets/place-holder.png'),
  ];
}

List<Widget> get inputFields => [
      DouaText.headline('Input Field'),
      vertical_space_small(),
      DouaText.body('Normal'),
      vertical_space_small(),
      DouaInputField(
        controller: TextEditingController(),
        placeholder: 'Enter Password',
      ),
      vertical_space_small(),
      DouaText.body('Leading Icon'),
      vertical_space_small(),
      DouaInputField(
        controller: TextEditingController(),
        leading: Icon(Icons.reset_tv),
        placeholder: 'Enter TV Code',
      ),
      vertical_space_small(),
      DouaText.body('Trailing Icon'),
      vertical_space_small(),
      DouaInputField(
        controller: TextEditingController(),
        trailing: Icon(Icons.clear_outlined),
        placeholder: 'Search for things',
      ),
    ];
