// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:intl/intl.dart'; // For date formatting
// import 'package:myapp/datamutasi_screen.dart';

// class GaleriInputPage extends StatefulWidget {
//   @override
//   _GaleriInputPageState createState() => _GaleriInputPageState();
// }

// class _GaleriInputPageState extends State<GaleriInputPage> {
//   List<String?> selectedFiles = [null, null, null];
//   TextEditingController noController = TextEditingController();
//   TextEditingController nikController = TextEditingController();
//   TextEditingController namaController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   TextEditingController usiaController = TextEditingController();
//   TextEditingController alamatController = TextEditingController();
//   TextEditingController pendidikanController = TextEditingController();
//   TextEditingController pekerjaanController = TextEditingController();
//   TextEditingController statusNikahController = TextEditingController();
//   TextEditingController statusMutasiController = TextEditingController();
//   DateTime? selectedDate;

//   // Fungsi untuk memilih file
//   void pickFile(int index) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       setState(() {
//         selectedFiles[index] = result.files.single.name;
//       });
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Galeri Input"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Container(
//         color: Colors.blue[50],
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             const Text(
//               "Galeri",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => DataMutasiPage()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue[900],
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text("Lihat Data"),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "A. Data Pribadi",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             buildFilePicker("Foto KTP", 0),
//             buildFilePicker("Foto KK", 1),
//             buildFilePicker("Surat Keterangan Pindah", 2),
//             const SizedBox(height: 20),
//             const Text(
//               "B. Formulir Mutasi Warga",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             buildCustomTextField("No", noController),
//             buildCustomTextField("NIK", nikController),
//             buildCustomTextField("Nama Mutasi", namaController),
//             buildCustomTextField("Jenis Kelamin", genderController),
//             buildCustomTextField("Usia", usiaController),
//             buildCustomTextField("Alamat", alamatController),
//             buildCustomTextField("Pendidikan", pendidikanController),
//             buildCustomTextField("Pekerjaan", pekerjaanController),
//             buildCustomTextField("Status Nikah", statusNikahController),
//             buildCustomTextField("Status Mutasi", statusMutasiController),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 const Text("Tanggal Mutasi:"),
//                 const SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () => _selectDate(context),
//                   child: Text(
//                     selectedDate == null
//                         ? 'Pilih Tanggal'
//                         : DateFormat('dd/MM/yyyy').format(selectedDate!),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (c) => DataMutasiPage()));
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue[900],
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text("Simpan"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget for file picker
//   Widget buildFilePicker(String label, int index) {
//     return Row(
//       children: [
//         Text(label),
//         const SizedBox(width: 20),
//         ElevatedButton(
//           onPressed: () => pickFile(index),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blue[900],
//             foregroundColor: Colors.white,
//           ),
//           child: const Text("Pilih File"),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Text(selectedFiles[index] ?? "Tidak ada file yang dipilih"),
//         ),
//       ],
//     );
//   }

//   // Widget for custom text fields
//   Widget buildCustomTextField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:myapp/datamutasi_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class GaleriInputPage extends StatefulWidget {
//   @override
//   _GaleriInputPageState createState() => _GaleriInputPageState();
// }

// class _GaleriInputPageState extends State<GaleriInputPage> {
//   final CollectionReference mutasiCollection =
//       FirebaseFirestore.instance.collection('mutasi');

//   List<String?> selectedFiles = [null, null, null];
//   List<String?> uploadedFileUrls = [
//     null,
//     null,
//     null
//   ]; // To store file URLs after upload
//   TextEditingController noController = TextEditingController();
//   TextEditingController nikController = TextEditingController();
//   TextEditingController namaController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   TextEditingController usiaController = TextEditingController();
//   TextEditingController alamatController = TextEditingController();
//   TextEditingController pendidikanController = TextEditingController();
//   TextEditingController pekerjaanController = TextEditingController();
//   TextEditingController statusNikahController = TextEditingController();
//   TextEditingController statusMutasiController = TextEditingController();
//   DateTime? selectedDate;

//   // Fungsi untuk memilih file
//   void pickFile(int index) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       setState(() {
//         selectedFiles[index] = result.files.single.path;
//       });
//     }
//   }

//   // Fungsi untuk mengunggah file ke Firebase Storage
//   Future<void> uploadFiles() async {
//     for (int i = 0; i < selectedFiles.length; i++) {
//       if (selectedFiles[i] != null) {
//         String fileName =
//             'mutasi/${DateTime.now().millisecondsSinceEpoch}_${i}';
//         Reference ref = FirebaseStorage.instance.ref().child(fileName);
//         UploadTask uploadTask = ref.putFile(File(selectedFiles[i]!));
//         final snapshot = await uploadTask.whenComplete(() => {});
//         final url = await snapshot.ref.getDownloadURL();
//         uploadedFileUrls[i] = url;
//       }
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   Future<void> saveDataToFirestore() async {
//     try {
//       // Upload files first
//       await uploadFiles();

//       // Save document in Firestore
//       await mutasiCollection.add({
//         'No': noController.text,
//         'NIK': nikController.text,
//         'NamaMutasi': namaController.text,
//         'JenisKelamin': genderController.text,
//         'Usia': usiaController.text,
//         'Alamat': alamatController.text,
//         'Pendidikan': pendidikanController.text,
//         'Pekerjaan': pekerjaanController.text,
//         'StatusNikah': statusNikahController.text,
//         'StatusMutasi': statusMutasiController.text,
//         'TanggalMutasi': selectedDate != null
//             ? DateFormat('dd/MM/yyyy').format(selectedDate!)
//             : null,
//         'FotoKTP': uploadedFileUrls[0],
//         'FotoKK': uploadedFileUrls[1],
//         'SuratKeteranganPindah': uploadedFileUrls[2],
//       });

//       // Show success message and navigate back to DataMutasiPage
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Data berhasil disimpan")),
//       );
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (c) => DataMutasiPage()));
//     } catch (e) {
//       // Handle any errors during the save process
//       print("Error saving data: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Terjadi kesalahan saat menyimpan data")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Galeri Input"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Container(
//         color: Colors.blue[50],
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             const Text(
//               "Galeri",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => DataMutasiPage()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue[900],
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text("Lihat Data"),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "A. Data Pribadi",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             buildFilePicker("Foto KTP", 0),
//             buildFilePicker("Foto KK", 1),
//             buildFilePicker("Surat Keterangan Pindah", 2),
//             const SizedBox(height: 20),
//             const Text(
//               "B. Formulir Mutasi Warga",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             buildCustomTextField("No", noController),
//             buildCustomTextField("NIK", nikController),
//             buildCustomTextField("Nama Mutasi", namaController),
//             buildCustomTextField("Jenis Kelamin", genderController),
//             buildCustomTextField("Usia", usiaController),
//             buildCustomTextField("Alamat", alamatController),
//             buildCustomTextField("Pendidikan", pendidikanController),
//             buildCustomTextField("Pekerjaan", pekerjaanController),
//             buildCustomTextField("Status Nikah", statusNikahController),
//             buildCustomTextField("Status Mutasi", statusMutasiController),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 const Text("Tanggal Mutasi:"),
//                 const SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () => _selectDate(context),
//                   child: Text(
//                     selectedDate == null
//                         ? 'Pilih Tanggal'
//                         : DateFormat('dd/MM/yyyy').format(selectedDate!),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: saveDataToFirestore,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue[900],
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text("Simpan"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget for file picker
//   Widget buildFilePicker(String label, int index) {
//     return Row(
//       children: [
//         Text(label),
//         const SizedBox(width: 20),
//         ElevatedButton(
//           onPressed: () => pickFile(index),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blue[900],
//             foregroundColor: Colors.white,
//           ),
//           child: const Text("Pilih File"),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Text(selectedFiles[index] != null
//               ? selectedFiles[index]!.split('/').last
//               : "Tidak ada file yang dipilih"),
//         ),
//       ],
//     );
//   }

//   // Widget for custom text fields
//   Widget buildCustomTextField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:myapp/datamutasi_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GaleriInputPage extends StatefulWidget {
  @override
  _GaleriInputPageState createState() => _GaleriInputPageState();
}

class _GaleriInputPageState extends State<GaleriInputPage> {
  final CollectionReference mutasiCollection =
      FirebaseFirestore.instance.collection('mutasi');

  List<String?> selectedFiles = [null, null, null];
  List<String?> uploadedFileUrls = [null, null, null];
  TextEditingController noController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController usiaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController pendidikanController = TextEditingController();
  TextEditingController pekerjaanController = TextEditingController();
  TextEditingController statusNikahController = TextEditingController();
  TextEditingController statusMutasiController = TextEditingController();
  DateTime? selectedDate;

  void pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedFiles[index] = result.files.single.path;
      });
    }
  }

  Future<void> uploadFiles() async {
    for (int i = 0; i < selectedFiles.length; i++) {
      if (selectedFiles[i] != null) {
        String fileName =
            'mutasi/${DateTime.now().millisecondsSinceEpoch}_${i}';
        Reference ref = FirebaseStorage.instance.ref().child(fileName);
        UploadTask uploadTask = ref.putFile(File(selectedFiles[i]!));
        final snapshot = await uploadTask.whenComplete(() => {});
        final url = await snapshot.ref.getDownloadURL();
        uploadedFileUrls[i] = url;
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> saveDataToFirestore() async {
    try {
      await uploadFiles();

      // Membuat peta data untuk Firestore
      Map<String, dynamic> data = {
        'No': noController.text,
        'NIK': nikController.text,
        'NamaMutasi': namaController.text,
        'JenisKelamin': genderController.text,
        'Usia': usiaController.text,
        'Alamat': alamatController.text,
        'Pendidikan': pendidikanController.text,
        'Pekerjaan': pekerjaanController.text,
        'StatusNikah': statusNikahController.text,
        'StatusMutasi': statusMutasiController.text,
        'TanggalMutasi': selectedDate != null
            ? DateFormat('dd/MM/yyyy').format(selectedDate!)
            : null,
      };

      // Menambahkan URL file jika ada
      if (uploadedFileUrls[0] != null) data['FotoKTP'] = uploadedFileUrls[0];
      if (uploadedFileUrls[1] != null) data['FotoKK'] = uploadedFileUrls[1];
      if (uploadedFileUrls[2] != null)
        data['SuratKeteranganPindah'] = uploadedFileUrls[2];

      await mutasiCollection.add(data);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data berhasil disimpan")),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => DataMutasiPage()));
    } catch (e) {
      print("Error saving data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan saat menyimpan data")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Galeri Input"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.blue[50],
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Galeri",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataMutasiPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                foregroundColor: Colors.white,
              ),
              child: const Text("Lihat Data"),
            ),
            const SizedBox(height: 20),
            const Text(
              "A. Data Pribadi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildFilePicker("Foto KTP", 0),
            buildFilePicker("Foto KK", 1),
            buildFilePicker("Surat Keterangan Pindah", 2),
            const SizedBox(height: 20),
            const Text(
              "B. Formulir Mutasi Warga",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildCustomTextField("No", noController),
            buildCustomTextField("NIK", nikController),
            buildCustomTextField("Nama Mutasi", namaController),
            buildCustomTextField("Jenis Kelamin", genderController),
            buildCustomTextField("Usia", usiaController),
            buildCustomTextField("Alamat", alamatController),
            buildCustomTextField("Pendidikan", pendidikanController),
            buildCustomTextField("Pekerjaan", pekerjaanController),
            buildCustomTextField("Status Nikah", statusNikahController),
            buildCustomTextField("Status Mutasi", statusMutasiController),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Tanggal Mutasi:"),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    selectedDate == null
                        ? 'Pilih Tanggal'
                        : DateFormat('dd/MM/yyyy').format(selectedDate!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveDataToFirestore,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                foregroundColor: Colors.white,
              ),
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilePicker(String label, int index) {
    return Row(
      children: [
        Text(label),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () => pickFile(index),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[900],
            foregroundColor: Colors.white,
          ),
          child: const Text("Pilih File"),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(selectedFiles[index] != null
              ? selectedFiles[index]!.split('/').last
              : "Tidak ada file yang dipilih"),
        ),
      ],
    );
  }

  Widget buildCustomTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
