import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dasboard_screen.dart';
import 'login_screen.dart';

class DataUserPage extends StatefulWidget {
  @override
  _DataUserPageState createState() => _DataUserPageState();
}

class _DataUserPageState extends State<DataUserPage> {
  final box = GetStorage();

  List<Map<String, String>> users = [
    {
      "No": "1",
      "Nama": "Rumses",
      "Username": "Rumses",
      "Keterangan": "admin",
      "Status": "Admin"
    },
    {
      "No": "2",
      "Nama": "Ketua RT",
      "Username": "RT01",
      "Keterangan": "KETUA RT01",
      "Status": "RT"
    },
    {
      "No": "3",
      "Nama": "Ketua RW",
      "Username": "RW01",
      "Keterangan": "KETUA RW01",
      "Status": "RW"
    },
  ];

  void _deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
    print("Data dihapus");
  }

  // Fungsi untuk logout
  void _logout(BuildContext context) async {
    // Hapus username dari shared preferences saat logout
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');

    // Hapus status login dan email dari GetStorage
    box.remove('isLoggedIn');
    box.remove('email');

    // Arahkan ke halaman login dan hapus semua route sebelumnya
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selamat Datang, CekWarga"),
        backgroundColor:
            const Color.fromARGB(255, 250, 248, 248), // Blue AppBar background
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(
          255, 200, 227, 250), // Light blue background for Scaffold
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Data User",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                        label: Text("No.",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text("Nama",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text("Username",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text("Keterangan",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text("Status",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text("Aksi",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: List<DataRow>.generate(
                    users.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text(users[index]["No"]!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                        DataCell(Text(users[index]["Nama"]!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                        DataCell(Text(users[index]["Username"]!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                        DataCell(Text(users[index]["Keterangan"]!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                        DataCell(Text(users[index]["Status"]!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteUser(index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
