import 'package:flutter/material.dart';

import 'doua_uikit.dart';

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
        primarySwatch: Colors.green,
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
      appBar: AppBar(
        leading: Icon(Icons.account_circle_rounded),
        // default is 56
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        children: [
          DouaText.headingOne('Design System'),
        ],
      ),
    );
  }
}
