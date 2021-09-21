import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';

import 'doua_onboarding_page.dart';
import 'initial_page.dart';

void main() {
  runApp(DouaApp());
}

class DouaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _materialApp();
  }

  Widget _materialApp() {
    return MaterialApp(
      title: 'Doua',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InitialPage('Doua'),
    );
  }
}

class InitialPage extends StatefulWidget {
  final String title;

  InitialPage(this.title) : super();

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        children: [
          DouaText.headingOne('Design System'),
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
