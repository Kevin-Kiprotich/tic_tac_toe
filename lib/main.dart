import 'package:flutter/material.dart';
import 'gamePage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Tic Tac Toe",
      home:TicTacToePage(),
    );
  }
}

class TicTacToePage extends StatelessWidget{
  const TicTacToePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body:GamePage(),
      ),
    );
  }
}