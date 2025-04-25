import 'package:flutter/material.dart';
import 'package:real_project/screens/games/gameone/piece.dart';
import 'package:real_project/screens/games/gameone/values.dart';
import 'pixel.dart';
import 'piece.dart';
class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
//grid
  int rowLenght = 10;
  int colLenght = 15;

  Piece currentPiece = Piece(type: Tetromino.L);

  @override
  void initState() {
    super.initState();

    startGame();
  }

  void startGame(){
    currentPiece.initializePiece();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        itemCount: rowLenght * colLenght,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: rowLenght),
       itemBuilder: (contex, index) {

        Pixel(
        color: Colors.grey[900],
        child:index,
        );
       } ,
           
       )
    );
  }
}