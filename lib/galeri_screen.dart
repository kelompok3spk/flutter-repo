import 'package:flutter/material.dart';
import 'package:myapp/dasboard_screen.dart';
import 'package:myapp/login_screen.dart';

import 'galeriinput_screen.dart';

// void main() {
//   runApp(MaterialApp(
//     home: GaleriPage(),
//   ));
// }

class GaleriPage extends StatelessWidget {
  const GaleriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Selamat Datang,CekWarga!"),
        backgroundColor: const Color.fromARGB(255, 227, 230, 233),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen()),
              );
              // Navigasi ke halaman dashboard
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
              // Fungsi logout
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Galeri",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GaleriInputPage()),
                    );
                    // Aksi Tambah
                  },
                  child: const Text("Tambah"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aksi Hapus
                  },
                  child: const Text("Hapus"),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Aksi Cetak
                //   },
                //   child: const Text("Cetak"),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Aksi Refresh
                //   },
                //   child: const Text("Refresh"),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("")),
                    DataColumn(label: Text("")),
                    DataColumn(label: Text("")),
                    DataColumn(label: Text("")),
                    DataColumn(label: Text("")),
                    DataColumn(label: Text("")),
                    DataColumn(label: Text("")),
                    DataColumn(label: Text("")),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text("")),
                      DataCell(Text("")),
                      DataCell(Text("")),
                      DataCell(Text("")),
                      DataCell(Text("")),
                      DataCell(Text("")),
                      DataCell(Text("")),
                      DataCell(Text("")),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
