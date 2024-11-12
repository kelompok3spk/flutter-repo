import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myapp/dasboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordHidden = true; // Status awal password tersembunyi
  final box = GetStorage(); // Menginisialisasi GetStorage

  Future<void> _signInWithEmailAndPassword() async {
    try {
      // Validasi input
      if (_usernameController.text.isEmpty ||
          _passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Username dan password tidak boleh kosong')),
        );
        return;
      }

      // Login dengan Firebase Authentication
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );

      // Jika login berhasil, arahkan ke halaman dashboard
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } on FirebaseAuthException catch (e) {
      // Tangani error login
      String errorMessage = 'Terjadi error saat login.';
      if (e.code == 'user-not-found') {
        errorMessage = 'Email tidak terdaftar.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Password salah.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'CekWarga',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Silahkan Login',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                  ),
                ),
                obscureText: isPasswordHidden,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _signInWithEmailAndPassword,
              child: const Text('LOGIN'),
            ),
          ],
        ),
      ),
    );
  }
}
