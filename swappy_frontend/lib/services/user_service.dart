import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = "http://10.0.2.2:8000/api";
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<void> createUser(String fullName, String phoneNumber, String email, String password) async {
    // Existing createUser logic
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth'), // Assuming the login endpoint is /api/auth
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final token = responseData['token'];

        if (token != null) {
          await secureStorage.write(key: 'token', value: token);
          print("Token saved: $token");
        } else {
          throw Exception("Invalid response: No token received");
        }
      } else {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        final errorMessage = errorResponse['message'] ?? 'Unknown error occurred';
        throw Exception(errorMessage);
      }
    } catch (error) {
      print("Error: $error");
      throw Exception(error.toString().replaceAll('Exception: ', ''));
    }
  }
}
