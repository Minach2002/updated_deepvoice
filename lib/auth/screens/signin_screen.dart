import 'package:flutter/material.dart';
import 'package:real_project/services/auth_service.dart';
import 'package:real_project/theme/theme.dart';
import 'package:real_project/widgets/custom_scaffold.dart';
import 'package:real_project/modules/user/screens/user_dashboard.dart';
import 'package:real_project/auth/screens/signup_screen.dart';
import 'package:real_project/modules/user/screens/forget_password_screen.dart'; 
import 'package:real_project/modules/user/user.dart';
import 'package:http/http.dart' as http;
import 'package:real_project/modules/admin/admin_dashboard.dart';
import 'package:real_project/modules/therapist/therapist_dashboard.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  Future<void> _handleSignIn() async {
    try {
      final response = await _authService.signIn(
        _emailController.text,
        _passwordController.text,
      );

      // Save token and role
      await AuthService.saveUserData(
        response['token'],
        response['user']['role'],
      );

      // Navigate based on role
      _navigateBasedOnRole(response['user']['role']);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void _navigateBasedOnRole(String role) {
    final Map<String, Widget> roleScreens = {
      'admin': AdminDashboard(),
      'therapist': TherapistDashboard(),
      'user': HomeScreen(),
    };

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => roleScreens[role] ?? HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(controller: _emailController),
            TextField(controller: _passwordController),
            ElevatedButton(
              onPressed: _handleSignIn,
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}