// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myapp/dasboard_screen.dart';
import 'package:myapp/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage(); // Mendapatkan instance GetStorage

  @override
  void initState() {
    super.initState();
    // Timer untuk menunggu splash screen beberapa detik
    Timer(Duration(seconds: 5), () {
      // Mengecek apakah pengguna sudah login
      if (box.read('isLoggedIn') == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Stack(
        children: [
          // Elemen teks dan loading di bagian atas
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 50.0), // Berikan sedikit padding dari atas
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Selamat Datang di CekWarga',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ],
              ),
            ),
          ),
          // Gambar di bagian dasar halaman
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/bg.png',
              height: 450, // Sesuaikan ukuran gambar
              width: 450, // Sesuaikan ukuran gambar
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
