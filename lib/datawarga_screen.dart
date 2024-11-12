// import 'package:flutter/material.dart';
// import 'package:myapp/galeriinput_screen.dart';
// import 'package:myapp/tambahdatawarga_screen.dart';

// class DataWargaScreen extends StatefulWidget {
//   const DataWargaScreen({super.key});

//   @override
//   _DataWargaScreenState createState() => _DataWargaScreenState();
// }

// class _DataWargaScreenState extends State<DataWargaScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   final List<Map<String, dynamic>> _dataWarga = [
//     {
//       'nama': 'Fernando',
//       'gender': 'L',
//       'usia': '29',
//       'pendidikan': 'S1',
//       'pekerjaan': 'Wiraswasta',
//       'nikah': 'Belum',
//       'status': 'Warga',
//     },
//     {
//       'nama': 'Ghania Azzahra',
//       'gender': 'P',
//       'usia': '35',
//       'pendidikan': 'SMA',
//       'pekerjaan': 'Karyawan',
//       'nikah': 'Sudah',
//       'status': 'Mutasi',
//     },
//   ];

//   void _addWarga() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => DataWargaForm()),
//     ).then((newWarga) {
//       if (newWarga != null) {
//         setState(() {
//           _dataWarga.add(newWarga);
//         });
//       }
//     });
//   }

//   void _editWarga(int index) {
//     final warga = _dataWarga[index];
//     TextEditingController namaController =
//         TextEditingController(text: warga['nama']);
//     TextEditingController genderController =
//         TextEditingController(text: warga['gender']);
//     TextEditingController usiaController =
//         TextEditingController(text: warga['usia']);
//     TextEditingController pendidikanController =
//         TextEditingController(text: warga['pendidikan']);
//     TextEditingController pekerjaanController =
//         TextEditingController(text: warga['pekerjaan']);
//     TextEditingController nikahController =
//         TextEditingController(text: warga['nikah']);
//     TextEditingController statusController =
//         TextEditingController(text: warga['status']);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Edit Data Warga"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                   controller: namaController,
//                   decoration: const InputDecoration(labelText: 'Nama')),
//               TextField(
//                   controller: genderController,
//                   decoration: const InputDecoration(labelText: 'L/P')),
//               TextField(
//                   controller: usiaController,
//                   decoration: const InputDecoration(labelText: 'Usia')),
//               TextField(
//                   controller: pendidikanController,
//                   decoration: const InputDecoration(labelText: 'Pendidikan')),
//               TextField(
//                   controller: pekerjaanController,
//                   decoration: const InputDecoration(labelText: 'Pekerjaan')),
//               TextField(
//                   controller: nikahController,
//                   decoration: const InputDecoration(labelText: 'Nikah')),
//               TextField(
//                   controller: statusController,
//                   decoration: const InputDecoration(labelText: 'Status')),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   _dataWarga[index] = {
//                     'nama': namaController.text,
//                     'gender': genderController.text,
//                     'usia': usiaController.text,
//                     'pendidikan': pendidikanController.text,
//                     'pekerjaan': pekerjaanController.text,
//                     'nikah': nikahController.text,
//                     'status': statusController.text,
//                   };
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Simpan"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Batal"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteWarga(int index) {
//     setState(() {
//       _dataWarga.removeAt(index);
//     });
//   }

//   void _mutateWarga(int index) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => GaleriInputPage()),
//     );
//     setState(() {
//       _dataWarga[index]['status'] = 'Mutasi';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredData = _dataWarga.where((warga) {
//       return warga['nama'].toLowerCase().contains(_searchQuery.toLowerCase());
//     }).toList();

//     int totalWarga = filteredData.length;
//     int jumlahLaki =
//         filteredData.where((warga) => warga['gender'] == 'L').length;
//     int jumlahPerempuan =
//         filteredData.where((warga) => warga['gender'] == 'P').length;
//     int wargaUnder17 =
//         filteredData.where((warga) => int.parse(warga['usia']) < 17).length;
//     int wargaAbove17 = totalWarga - wargaUnder17;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Selamat Datang,CekWarga!'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//                 Icons.refresh), // Menggunakan Icon untuk mengemas Icons.refresh
//             onPressed: () {
//               // Tambahkan logika untuk refresh data di sini
//               print('Refreshing data...'); // Placeholder untuk action refresh
//             },
//           ),
//         ],
//       ),
//       backgroundColor: const Color.fromARGB(255, 200, 227, 250),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Data Warga',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Cari Warga',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onChanged: (query) {
//                 setState(() {
//                   _searchQuery = query.toLowerCase();
//                 });
//               },
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 58, 112, 228),
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 15),
//                   ),
//                   onPressed: _addWarga,
//                   child: const Text('Tambah Warga'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Table(
//                   columnWidths: const {
//                     0: FixedColumnWidth(35),
//                     1: FixedColumnWidth(100),
//                     2: FixedColumnWidth(50),
//                     3: FixedColumnWidth(50),
//                     4: FixedColumnWidth(100),
//                     5: FixedColumnWidth(100),
//                     6: FixedColumnWidth(70),
//                     7: FixedColumnWidth(70),
//                     8: FixedColumnWidth(100),
//                   },
//                   children: [
//                     const TableRow(
//                       children: [
//                         Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text('No',
//                                 style: TextStyle(fontWeight: FontWeight.bold))),
//                         Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text('Nama',
//                                 style: TextStyle(fontWeight: FontWeight.bold))),
//                         Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text('L/P',
//                                 style: TextStyle(fontWeight: FontWeight.bold))),
//                         Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text('Usia',
//                                 style: TextStyle(fontWeight: FontWeight.bold))),
//                         Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text('Pendidikan',
//                                 style: TextStyle(fontWeight: FontWeight.bold))),
//                         Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text('Pekerjaan',
//                                 style: TextStyle(fontWeight: FontWeight.bold))),
//                         Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text('Nikah',
//                                 style: TextStyle(fontWeight: FontWeight.bold))),
//                         Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text('Status',
//                                 style: TextStyle(fontWeight: FontWeight.bold))),
//                         Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text('Aksi',
//                                 style: TextStyle(fontWeight: FontWeight.bold))),
//                       ],
//                     ),
//                     ...filteredData.asMap().entries.map((entry) {
//                       int index = entry.key;
//                       var warga = entry.value;
//                       return TableRow(
//                         children: [
//                           Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text('${index + 1}')),
//                           Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(warga['nama'])),
//                           Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(warga['gender'])),
//                           Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text('${warga['usia']}')),
//                           Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(warga['pendidikan'])),
//                           Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(warga['pekerjaan'])),
//                           Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 8.0),
//                               child: Text(warga['nikah'])),
//                           Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 8.0),
//                               child: Text(warga['status'])),
//                           Row(
//                             children: [
//                               IconButton(
//                                 icon:
//                                     const Icon(Icons.edit, color: Colors.blue),
//                                 onPressed: () => _editWarga(index),
//                               ),
//                               IconButton(
//                                 icon:
//                                     const Icon(Icons.delete, color: Colors.red),
//                                 onPressed: () => _deleteWarga(index),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.swap_horiz,
//                                     color: Colors.green),
//                                 onPressed: () => _mutateWarga(index),
//                               ),
//                             ],
//                           ),
//                         ],
//                       );
//                     }).toList(),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               const Text('Total Warga',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               Text('$totalWarga orang')
//             ]),
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               const Text('Jumlah Laki-Laki',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               Text('$jumlahLaki orang')
//             ]),
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               const Text('Jumlah Perempuan',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               Text('$jumlahPerempuan orang')
//             ]),
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               const Text('Warga < 17 tahun',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               Text('$wargaUnder17 orang')
//             ]),
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               const Text('Warga >= 17 tahun',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               Text('$wargaAbove17 orang')
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:myapp/tambahdatawarga_screen.dart';

// class DataWargaScreen extends StatefulWidget {
//   const DataWargaScreen({super.key});

//   @override
//   _DataWargaScreenState createState() => _DataWargaScreenState();
// }

// class _DataWargaScreenState extends State<DataWargaScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   final CollectionReference wargaCollection =
//       FirebaseFirestore.instance.collection('warga');

//   void _addWarga() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => DataWargaForm()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Selamat Datang, CekWarga!'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               setState(() {});
//             },
//           ),
//         ],
//       ),
//       backgroundColor: const Color.fromARGB(255, 200, 227, 250),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Data Warga',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Cari Warga',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onChanged: (query) {
//                 setState(() {
//                   _searchQuery = query.toLowerCase();
//                 });
//               },
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 58, 112, 228),
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 15),
//                   ),
//                   onPressed: _addWarga,
//                   child: const Text('Tambah Warga'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: wargaCollection.snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Center(child: Text('Tidak ada data warga.'));
//                   }

//                   final dataWarga = snapshot.data!.docs
//                       .where((doc) =>
//                           doc['Nama'] // disesuaikan dengan 'Nama' dari Firebase
//                               .toString()
//                               .toLowerCase()
//                               .contains(_searchQuery))
//                       .toList();

//                   return SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Table(
//                       columnWidths: const {
//                         0: FixedColumnWidth(35),
//                         1: FixedColumnWidth(80),
//                         2: FixedColumnWidth(100),
//                         3: FixedColumnWidth(50),
//                         4: FixedColumnWidth(100),
//                         5: FixedColumnWidth(80),
//                         6: FixedColumnWidth(80),
//                         7: FixedColumnWidth(80),
//                         8: FixedColumnWidth(80),
//                         9: FixedColumnWidth(120),
//                       },
//                       children: [
//                         const TableRow(
//                           children: [
//                             Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('No',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold))),
//                             Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('NIK',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold))),
//                             Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Nama',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold))),
//                             Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('TTL',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold))),
//                             Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Jenis Kelamin',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold))),
//                             Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Alamat',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold))),
//                             Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Agama',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold))),
//                             Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Pekerjaan',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold))),
//                             Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Status Nikah',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold))),
//                             Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Kewarganegaraan',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold))),
//                           ],
//                         ),
//                         ...dataWarga.asMap().entries.map((entry) {
//                           int index = entry.key;
//                           var warga =
//                               entry.value.data() as Map<String, dynamic>;
//                           return TableRow(
//                             children: [
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text('${index + 1}')),
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(warga['NIK'] ?? '')),
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(warga['Nama'] ?? '')),
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(warga['TTL'] ?? '')),
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(warga['JenisKelamin'] ?? '')),
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(warga['Alamat'] ?? '')),
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(warga['Agama'] ?? '')),
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(warga['Pekerjaan'] ?? '')),
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(warga['StatusNikah'] ?? '')),
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(warga['Kewarganegaraan'] ?? '')),
//                             ],
//                           );
//                         }).toList(),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/tambahdatawarga_screen.dart';

class DataWargaScreen extends StatefulWidget {
  const DataWargaScreen({super.key});

  @override
  _DataWargaScreenState createState() => _DataWargaScreenState();
}

class _DataWargaScreenState extends State<DataWargaScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int totalWarga = 0;
  int jumlahLaki = 0;
  int jumlahPerempuan = 0;

  final CollectionReference wargaCollection =
      FirebaseFirestore.instance.collection('warga');

  void _addWarga() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DataWargaForm()),
    );
  }

  Future<void> _deleteWarga(String docId) async {
    await wargaCollection.doc(docId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data Warga Berhasil Dihapus")),
    );
  }

  void _editWarga(DocumentSnapshot warga) {
    final TextEditingController nikController =
        TextEditingController(text: warga['NIK']);
    final TextEditingController namaController =
        TextEditingController(text: warga['Nama']);
    final TextEditingController ttlController =
        TextEditingController(text: warga['TTL']);
    final TextEditingController jenisKelaminController =
        TextEditingController(text: warga['JenisKelamin']);
    final TextEditingController alamatController =
        TextEditingController(text: warga['Alamat']);
    final TextEditingController agamaController =
        TextEditingController(text: warga['Agama']);
    final TextEditingController pekerjaanController =
        TextEditingController(text: warga['Pekerjaan']);
    final TextEditingController statusNikahController =
        TextEditingController(text: warga['StatusNikah']);
    final TextEditingController kewarganegaraanController =
        TextEditingController(text: warga['Kewarganegaraan']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Data Warga'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                customTextField(nikController, "NIK"),
                customTextField(namaController, "Nama"),
                customTextField(ttlController, "Tempat Tanggal Lahir"),
                customTextField(jenisKelaminController, "Jenis Kelamin"),
                customTextField(alamatController, "Alamat"),
                customTextField(agamaController, "Agama"),
                customTextField(pekerjaanController, "Pekerjaan"),
                customTextField(statusNikahController, "Status Nikah"),
                customTextField(kewarganegaraanController, "Kewarganegaraan"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                await wargaCollection.doc(warga.id).update({
                  'NIK': nikController.text,
                  'Nama': namaController.text,
                  'TTL': ttlController.text,
                  'JenisKelamin': jenisKelaminController.text,
                  'Alamat': alamatController.text,
                  'Agama': agamaController.text,
                  'Pekerjaan': pekerjaanController.text,
                  'StatusNikah': statusNikahController.text,
                  'Kewarganegaraan': kewarganegaraanController.text,
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Data Warga Berhasil Diperbarui")),
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
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

  Future<void> _fetchStatistics() async {
    final QuerySnapshot snapshot = await wargaCollection.get();
    final allData = snapshot.docs;

    setState(() {
      totalWarga = allData.length;
      jumlahLaki =
          allData.where((doc) => doc['JenisKelamin'] == 'Laki-Laki').length;
      jumlahPerempuan =
          allData.where((doc) => doc['JenisKelamin'] == 'Perempuan').length;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selamat Datang, CekWarga!'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
              _fetchStatistics();
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 200, 227, 250),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Data Warga',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari Warga',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 58, 112, 228),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                  ),
                  onPressed: _addWarga,
                  child: const Text('Tambah Warga'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: wargaCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('Tidak ada data warga.'));
                  }

                  final dataWarga = snapshot.data!.docs
                      .where((doc) => doc['Nama']
                          .toString()
                          .toLowerCase()
                          .contains(_searchQuery))
                      .toList();

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(35),
                        1: FixedColumnWidth(80),
                        2: FixedColumnWidth(100),
                        3: FixedColumnWidth(50),
                        4: FixedColumnWidth(100),
                        5: FixedColumnWidth(80),
                        6: FixedColumnWidth(80),
                        7: FixedColumnWidth(80),
                        8: FixedColumnWidth(80),
                        9: FixedColumnWidth(120),
                        10: FixedColumnWidth(120),
                      },
                      children: [
                        const TableRow(
                          children: [
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('No',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('NIK',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Nama',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('TTL',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Jenis Kelamin',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Alamat',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Agama',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Pekerjaan',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Status Nikah',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Kewarganegaraan',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Aksi',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ],
                        ),
                        ...dataWarga.asMap().entries.map((entry) {
                          int index = entry.key;
                          var warga = entry.value;
                          return TableRow(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${index + 1}')),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(warga['NIK'] ?? '')),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(warga['Nama'] ?? '')),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(warga['TTL'] ?? '')),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(warga['JenisKelamin'] ?? '')),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(warga['Alamat'] ?? '')),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(warga['Agama'] ?? '')),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(warga['Pekerjaan'] ?? '')),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(warga['StatusNikah'] ?? '')),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(warga['Kewarganegaraan'] ?? '')),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () => _editWarga(warga),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _deleteWarga(warga.id),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Warga',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('$totalWarga orang'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Jumlah Laki-Laki',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('$jumlahLaki orang'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Jumlah Perempuan',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('$jumlahPerempuan orang'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
