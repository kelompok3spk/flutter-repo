// import 'package:flutter/material.dart';
// import 'datakartukeluarga_screen.dart'; // Pastikan file ini ada dan benar

// class DataKartukeluargaForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Selamat Datang, Cek Warga!"),
//         backgroundColor: Colors.white, // Warna AppBar putih
//         foregroundColor:
//             const Color.fromARGB(255, 3, 11, 19), // Warna teks AppBar
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh), // Tombol refresh
//             onPressed: () {
//               // Tambahkan logika refresh di sini
//               print('Refreshing data...'); // Placeholder untuk action refresh
//             },
//           ),
//         ],
//       ),
//       backgroundColor:
//           const Color.fromARGB(24, 33, 149, 243), // Set background warna
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Tambah Kartu Keluarga",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               sectionTitle("A. Data Pribadi"),
//               customTextField("Nomor Kartu Keluarga"),
//               customTextField("Nama Kepala Keluarga"),
//               sectionTitle("B. Data Alamat"),
//               customTextField("Alamat"),
//               customTextField("Desa/Kelurahan"),
//               customTextField("Kecamatan"),
//               customTextField("Kabupaten/Kota"),
//               customTextField("Provinsi"),
//               customTextField("Negara"),
//               customTextField("RT"),
//               customTextField("RW"),
//               customTextField("Kode Pos"),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Menampilkan snackbar dengan pesan "Berhasil disimpan"
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text("Berhasil disimpan"),
//                       duration: Duration(seconds: 2),
//                     ),
//                   );

//                   // Navigasi ke halaman berikutnya jika perlu
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const DataKartuKeluargaScreen(),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue[900], // Background button biru
//                   foregroundColor: Colors.white, // Text button putih
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'datakartukeluarga_screen.dart'; // Pastikan file ini ada dan benar

class DataKartuKeluargaForm extends StatelessWidget {
  final TextEditingController nomorKKController = TextEditingController();
  final TextEditingController namaKKController = TextEditingController();
  final TextEditingController jumlahAnggotaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController kodePosController = TextEditingController();

  void _saveDataToFirebase(BuildContext context) async {
    final docKK = FirebaseFirestore.instance.collection('kartu_keluarga').doc();
    await docKK.set({
      'NomorKK': nomorKKController.text,
      'NamaKK': namaKKController.text,
      'JumlahAnggota': int.parse(jumlahAnggotaController.text),
      'Alamat': alamatController.text,
      'KodePos': kodePosController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data Kartu Keluarga Berhasil Disimpan")),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DataKartuKeluargaScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selamat Datang, Cek Warga!"),
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 3, 11, 19),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              print('Refreshing data...');
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(24, 33, 149, 243),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tambah Kartu Keluarga",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              sectionTitle("A. Data Pribadi"),
              customTextField(nomorKKController, "Nomor Kartu Keluarga"),
              customTextField(namaKKController, "Nama Kepala Keluarga"),
              customTextField(jumlahAnggotaController, "Jumlah Anggota"),
              sectionTitle("B. Data Alamat"),
              customTextField(alamatController, "Alamat"),
              customTextField(kodePosController, "Kode Pos"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveDataToFirebase(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white,
                ),
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: label == "Jumlah Anggota" ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
