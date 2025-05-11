import 'package:flutter/material.dart';

class TherapistProfileScreen extends StatelessWidget {
  final Map<String, String> therapist;

  const TherapistProfileScreen({super.key, required this.therapist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(therapist['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(therapist['photo']!),
            ),
            const SizedBox(height: 20),
            Text(
              'Specialization: ${therapist['specialization']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // You can add more therapist details here
            ElevatedButton(
              onPressed: () {
                // Action when the user wants to book an appointment
              },
              child: const Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
