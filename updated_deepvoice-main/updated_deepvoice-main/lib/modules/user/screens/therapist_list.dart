import 'package:flutter/material.dart';
import 'package:real_project/modules/user/screens/therapist_profiles.dart';

class TherapistListScreen extends StatelessWidget {
  final List<Map<String, String>> therapists = [
    {'name': 'Dr. John Doe', 'specialization': 'Psychologist', 'photo': 'https://example.com/photo.jpg'},
    {'name': 'Dr. Jane Smith', 'specialization': 'Therapist', 'photo': 'https://example.com/photo.jpg'},
    // Add more therapists here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Approved Therapists'),
      ),
      body: ListView.builder(
        itemCount: therapists.length,
        itemBuilder: (context, index) {
          final therapist = therapists[index];
          return ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(therapist['photo']!),
            ),
            title: Text(therapist['name']!),
            subtitle: Text(therapist['specialization']!),
            onTap: () {
              // Navigate to therapist profile details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TherapistProfileScreen(therapist: therapist),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
