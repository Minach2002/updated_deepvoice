import 'package:flutter/material.dart';
import 'package:real_project/modules/user/screens/games/gameone/gamesone.dart';

class GamesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose a Game')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            leading: Icon(Icons.games),
            title: Text('Game 1'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => Gamesone()));
            },
          ),
          ListTile(
            leading: Icon(Icons.sports_esports),
            title: Text('Game 2'),
            onTap: () {},
          ),
          // Add more games here as needed
        ],
      ),
    );
  }
}
