import 'package:flutter/material.dart';
import 'board.dart'; // Make sure to import the GameBoard file

class Gamesone extends StatelessWidget {
  const Gamesone({super.key});

  @override
  Widget build(BuildContext context) {
    return const GameBoard(); // Display your custom grid game board
  }
}
