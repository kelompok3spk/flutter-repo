// import 'package:flutter/material.dart';
// import 'package:myapp/dasboard_screen.dart';
// import 'package:myapp/datawarga_screen.dart';
// import 'login_screen.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Data Warga',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DataWargaForm(),
//     );
//   }
// }

// class DataWargaForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Selamat Datang, CekWarga!"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const DashboardScreen()),
//               );
//             },
//             icon: const Icon(Icons.dashboard),
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const LoginScreen()),
//               );
//             },
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       backgroundColor: const Color.fromARGB(255, 200, 227, 250),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Tambah Data Warga",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               sectionTitle("A. Data Pribadi"),
//               customTextField("NIK"),
//               customTextField("Nama"),
//               customTextField("Tempat Lahir"),
//               customTextField("Tanggal Lahir"),
//               customTextField("Jenis Kelamin"),
//               sectionTitle("B. Data Alamat"),
//               customTextField("Alamat KTP"),
//               customTextField("Alamat"),
//               customTextField("Desa/Kelurahan"),
//               customTextField("Kecamatan"),
//               customTextField("Kabupaten/Kota"),
//               customTextField("Provinsi"),
//               customTextField("Negara"),
//               customTextField("RT"),
//               customTextField("RW"),
//               sectionTitle("C. Data Lain-Lain"),
//               customTextField("Agama"),
//               customTextField("Pendidikan Terakhir"),
//               customTextField("Pekerjaan"),
//               customTextField("Status Pernikahan"),
//               customTextField("Status Tinggal"),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Menampilkan Snackbar dengan pesan "Berhasil Disimpan"
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text("Berhasil Disimpan"),
//                     ),
//                   );

//                   // Navigasi ke DataWargaScreen
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (c) => const DataWargaScreen()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue[900],
//                   foregroundColor: Colors.white,
//                 ),
//                 child: const Text("Simpan"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget customTextField(String label) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }

//   Widget sectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Remove unused imports if they are not used in this file
// ignore: unused_import
import 'package:myapp/dasboard_screen.dart';
// ignore: unused_import
import 'package:myapp/datawarga_screen.dart';
// ignore: unused_import
import 'package:myapp/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Warga',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DataWargaForm(),
    );
  }
}

class DataWargaForm extends StatefulWidget {
  const DataWargaForm({super.key});

  @override
  State<DataWargaForm> createState() => _DataWargaFormState();
}

class _DataWargaFormState extends State<DataWargaForm> {
  final TextEditingController nikController = TextEditingController();

  final TextEditingController namaController = TextEditingController();

  final TextEditingController ttlController = TextEditingController();

  final TextEditingController alamatController = TextEditingController();

  final TextEditingController agamaController = TextEditingController();

  final TextEditingController pekerjaanController = TextEditingController();

  final TextEditingController statusNikahController = TextEditingController();

  final TextEditingController kewarganegaraanController =
      TextEditingController();

  String jenisKelamin = 'Laki-Laki';

  void _saveDataToFirebase(BuildContext context) async {
    final docWarga = FirebaseFirestore.instance.collection('warga').doc();
    await docWarga.set({
      'NIK': nikController.text,
      'Nama': namaController.text,
      'TTL': ttlController.text,
      'JenisKelamin': jenisKelamin,
      'Alamat': alamatController.text,
      'Agama': agamaController.text,
      'Pekerjaan': pekerjaanController.text,
      'StatusNikah': statusNikahController.text,
      'Kewarganegaraan': kewarganegaraanController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data Warga Berhasil Disimpan")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Data Warga")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            customTextField(nikController, "NIK"),
            customTextField(namaController, "Nama"),
            customTextField(ttlController, "Tempat Tanggal Lahir"),
            const SizedBox(height: 16),
            const Text("Jenis Kelamin",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio<String>(
                  value: 'Laki-Laki',
                  groupValue: jenisKelamin,
                  onChanged: (value) {
                    setState(() {
                      jenisKelamin = value!;
                    });
                  },
                ),
                const Text('Laki-Laki'),
                Radio<String>(
                  value: 'Perempuan',
                  groupValue: jenisKelamin,
                  onChanged: (value) {
                    setState(() {
                      jenisKelamin = value!;
                    });
                  },
                ),
                const Text('Perempuan'),
              ],
            ),
            customTextField(alamatController, "Alamat"),
            customTextField(agamaController, "Agama"),
            customTextField(pekerjaanController, "Pekerjaan"),
            customTextField(statusNikahController, "Status Nikah"),
            customTextField(kewarganegaraanController, "Kewarganegaraan"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveDataToFirebase(context),
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
