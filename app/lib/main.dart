import 'package:flutter/material.dart';

void main() => runApp(App());

// Raccourci : Saisisser 'stless' puis appuyer sur Enter
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Tracker',
      theme: ThemeData(primaryColor: Colors.indigo),
    );
  }
}
