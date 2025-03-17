import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:flutter/material.dart';
import 'package:real_project/widgets/custom_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showAppBar: true,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 7,
                child: Center(
                  child: Text(
                    'Welcome to the Home Screen!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 28,
            bottom: MediaQuery.of(context).size.height / 4,
            child: FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Microphone button pressed')),
                );
              },
              child: const Icon(Icons.mic),
            ),
          ),
        ],
      ),
    );
  }
}
