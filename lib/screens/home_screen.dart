import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:real_project/widgets/custom_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioRecorder _audioRecorder = AudioRecorder(); // Use the correct factory constructor

  bool isRecording = false; 
  String? _filePath;

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/audio_record.m4a';

        await _audioRecorder.start(const RecordConfig(), path: filePath); // Use RecordConfig
        setState(() {
          isRecording = true;
          _filePath = filePath;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission denied')),
        );
      }
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      if (isRecording) {
        final path = await _audioRecorder.stop();
        setState(() {
          isRecording = false;
          _filePath = path;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recording saved at $_filePath')),
        );
      }
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

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
              onPressed: isRecording ? _stopRecording : _startRecording,
              backgroundColor: isRecording ? Colors.red : Colors.blue,
              child: Icon(isRecording ? Icons.stop : Icons.mic),
            ),
          ),
        ],
      ),
    );
  }
}