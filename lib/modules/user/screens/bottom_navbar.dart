import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: const Color.fromARGB(255, 0, 82, 149),  // Active icon/text color
      unselectedItemColor: Colors.lightBlue,  // Inactive icon/text color
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home'
          ),
          
          BottomNavigationBarItem(
          icon: Icon(Icons.videogame_asset),
          label: 'Games'
          ),

          BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Analyze'
          ),

          BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile'
          ),
      ],
      );
  }
}