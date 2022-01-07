import 'package:flutter/material.dart';
import 'home_page.dart';

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
      //home: ShowCaseInitialPage('Doua'),
      home: HomePage('Doua'),
    );
  }
}
