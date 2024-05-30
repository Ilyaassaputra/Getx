import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/domain/utils/api_endpoint.dart';
import 'package:getx_test/presentation/home/home.screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final username = ''.obs;
  final password = ''.obs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var url =
      Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginApi);

  // Fungsi untuk mengambil nilai input dan menampilkan dialog
  void onLoginButtonPressed() {
    // Lakukan validasi apakah username dan password sesuai dengan kondisi tertentu
    if (username.value.isNotEmpty && password.value.isNotEmpty) {
      // Panggil fungsi loginUser dengan username dan password dari controller
      loginUser(username.value, password.value);
    } else {
      // Tampilkan dialog bahwa username dan password harus diisi
      _showEmptyFieldDialog();
    }
  }

  // Method to show dialog for empty fields
  void _showEmptyFieldDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Login Failed'),
        content: Text('Please fill in both username and password.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk melakukan panggilan API login
  Future<void> loginUser(String username, String password) async {
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['is_valid'] == true) {
          final SharedPreferences? prefs = await _prefs;
          prefs!.setString('token', json['token']);

          _saveTokenToPrefs(json['token'], json['data']['username']);
        } else {
          _showLoginFailedDialog(json['message']);
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknown Error Occured";
      }
    } catch (e) {
      Get.back();
      // get dialog
      Get.dialog(
        AlertDialog(
          title: Text('Login Failed'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // Fungsi untuk menyimpan token ke SharedPreferences
  Future<void> _saveTokenToPrefs(String token, String username) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('token', token);
    await prefs.setString('username', username);
    Get.snackbar(
      'Hi 👋',
      'Selamat Datang $username',
      backgroundColor: Colors.lightBlue, // Atur warna sesuai keinginanmu
    );
    Get.offAll(HomeScreen(nama: username));
    // Tambahkan snackbar di sini
  }

  // Method to show dialog for login failure
  void _showLoginFailedDialog(String errorMessage) {
    Get.dialog(
      AlertDialog(
        title: Text('Login Failed'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Method untuk menampilkan snackbar responsif
  void showResponsiveSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
