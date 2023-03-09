import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Utils/prefs.dart';
import 'home_page.dart';
import 'show_case_initial_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      // home: ShowCaseInitialPage('Doua'),
      home: HomePage('Doua'),
    );
  }
}
