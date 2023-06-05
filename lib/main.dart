import 'package:flutter/material.dart';
import 'package:tic_tac_toe/presentation/screens/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage()
    );
  }
}


/*

TODO

-UPDATE LOGIC OF RESET BOARD
-UPDATE LOGIC OF CLEAR SCOREBOARD

*/