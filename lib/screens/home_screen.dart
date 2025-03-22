import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:http_parser/http_parser.dart'; // For MediaType
import 'dart:convert'; // For json.decode

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();
  String? recordingPath;
  bool isRecording = false, isPlaying = false;
  String? predictedEmotion; // To store the predicted emotion

  // Function to send the audio file to the Flask server
  Future<void> _sendAudioToServer(String filePath) async {
    print('Sending audio file to server: $filePath'); // Debug log

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://4e2e-34-126-85-40.ngrok-free.app/predict'), // Use your ngrok URL
    );

    // Attach the audio file
    request.files.add(
      await http.MultipartFile.fromPath(
        'file', // Field name (must match the Flask server's expected field)
        filePath, // Path to the audio file
        contentType: MediaType('audio', 'wav'), // Set the content type
      ),
    );

    // Send the request
    try {
      var response = await request.send();
      print('Response status code: ${response.statusCode}'); // Debug log

      if (response.statusCode == 200) {
        // Read the response
        var responseData = await response.stream.bytesToString();
        print('Server response: $responseData'); // Debug log

        // Parse the JSON response
        var jsonResponse = json.decode(responseData);
        setState(() {
          predictedEmotion = jsonResponse['emotion']; // Update the predicted emotion
        });
      } else {
        // Handle errors
        setState(() {
          predictedEmotion = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      // Handle exceptions
      print('Error sending request: $e'); // Debug log
      setState(() {
        predictedEmotion = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _recordingButton(),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (recordingPath != null)
            MaterialButton(
              onPressed: () async {
                if (audioPlayer.state == PlayerState.playing) {
                  // Stop the audio if it's playing
                  await audioPlayer.stop();
                  setState(() {
                    isPlaying = false;
                  });
                } else {
                  // Play the audio if it's not playing
                  await audioPlayer.play(DeviceFileSource(recordingPath!));
                  setState(() {
                    isPlaying = true;
                  });
                }
              },
              color: Theme.of(context).colorScheme.primary,
              child: Text(
                isPlaying ? "Stop Playing Recording" : "Start Playing Recording",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          if (recordingPath == null) const Text('No Recording Found :('),
          if (predictedEmotion != null) // Display the predicted emotion
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Predicted Emotion: $predictedEmotion',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _recordingButton() {
    return FloatingActionButton(
      onPressed: () async {
        if (isRecording) {
          // Stop recording
          String? filePath = await audioRecorder.stop();
          if (filePath != null) {
            setState(() {
              isRecording = false;
              recordingPath = filePath;
            });

            // Send the audio file to the server
            await _sendAudioToServer(filePath);
          }
        } else {
          // Start recording
          if (await audioRecorder.hasPermission()) {
            final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
            final String filePath = p.join(appDocumentsDir.path, "recording.wav");
            await audioRecorder.start(const RecordConfig(), path: filePath);
            setState(() {
              isRecording = true;
              recordingPath = null;
            });
          }
        }
      },
      child: Icon(
        isRecording ? Icons.stop : Icons.mic,
      ),
    );
  }
}