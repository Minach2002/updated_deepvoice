import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl = 'http://10.0.2.2:8080/api/auth'; // For emulator

  // Signin Method
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  // Signup Method
  Future<Map<String, dynamic>> signUp(String email, String password, String role) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'role': role,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Registration failed: ${response.body}');
    }
  }

  // Shared Preferences Helper
  static Future<void> saveUserData(String token, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('user_role', role);
  }
}