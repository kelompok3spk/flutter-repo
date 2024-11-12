// import 'package:flutter/material.dart';
// import 'package:myapp/tambahdatakk_screen.dart';

// class DataKartuKeluargaScreen extends StatefulWidget {
//   const DataKartuKeluargaScreen({super.key});

//   @override
//   _DataKartuKeluargaScreenState createState() =>
//       _DataKartuKeluargaScreenState();
// }

// class _DataKartuKeluargaScreenState extends State<DataKartuKeluargaScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   // Dummy data untuk contoh, silakan sesuaikan dengan data yang aktual
//   final List<Map<String, dynamic>> _dataKartuKeluarga = [
//     {
//       'nokk': '1234567890',
//       'namakk': 'Rumses',
//       'nikkk': '987654321',
//       'anggota': '5',
//       'alamat': 'Jalan Melati No.1',
//       'rt': '01',
//       'rw': '02',
//     },
//     {
//       'nokk': '1234567891',
//       'namakk': 'Lina',
//       'nikkk': '987654322',
//       'anggota': '3',
//       'alamat': 'Jalan Kenanga No.5',
//       'rt': '01',
//       'rw': '02',
//     },
//   ];

//   void _addWarga() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => DataKartuKeluargaForm()),
//     ).then((newWarga) {
//       if (newWarga != null) {
//         setState(() {
//           _dataKartuKeluarga.add(newWarga);
//         });
//       }
//     });
//   }

//   void _editWarga(int index) {
//     final warga = _dataKartuKeluarga[index];
//     TextEditingController nokkController =
//         TextEditingController(text: warga['nokk']);
//     TextEditingController namakkController =
//         TextEditingController(text: warga['namakk']);
//     TextEditingController nikkkController =
//         TextEditingController(text: warga['nikkk']);
//     TextEditingController anggotaController =
//         TextEditingController(text: warga['anggota']);
//     TextEditingController alamatController =
//         TextEditingController(text: warga['alamat']);
//     TextEditingController rtController =
//         TextEditingController(text: warga['rt']);
//     TextEditingController rwController =
//         TextEditingController(text: warga['rw']);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Edit Data Kartu Keluarga"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: nokkController,
//                 decoration: const InputDecoration(labelText: 'Nomor KK'),
//               ),
//               TextField(
//                 controller: namakkController,
//                 decoration: const InputDecoration(labelText: 'Nama KK'),
//               ),
//               TextField(
//                 controller: nikkkController,
//                 decoration: const InputDecoration(labelText: 'NIK KK'),
//               ),
//               TextField(
//                 controller: anggotaController,
//                 decoration: const InputDecoration(labelText: 'Jml. Anggota'),
//               ),
//               TextField(
//                 controller: alamatController,
//                 decoration: const InputDecoration(labelText: 'Alamat'),
//               ),
//               TextField(
//                 controller: rtController,
//                 decoration: const InputDecoration(labelText: 'RT'),
//               ),
//               TextField(
//                 controller: rwController,
//                 decoration: const InputDecoration(labelText: 'RW'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   _dataKartuKeluarga[index] = {
//                     'nokk': nokkController.text,
//                     'namakk': namakkController.text,
//                     'nikkk': nikkkController.text,
//                     'anggota': anggotaController.text,
//                     'alamat': alamatController.text,
//                     'rt': rtController.text,
//                     'rw': rwController.text,
// // Maintain the existing status
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
//       _dataKartuKeluarga.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Filtering data based on search query
//     final filteredData = _dataKartuKeluarga.where((warga) {
//       return warga['namakk'].toLowerCase().contains(_searchQuery);
//     }).toList();

//     return Scaffold(
//       appBar: AppBar(
//           title: const Text('Selamat Datang CekWarga!'),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.refresh),
//               onPressed: () {},
//             ),
//           ]),
//       backgroundColor: Color.fromARGB(255, 200, 227, 255),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Data Kartu Keluarga',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               // Search bar
//               TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   labelText: 'Cari Kartu Keluarga',
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onChanged: (query) {
//                   setState(() {
//                     _searchQuery = query.toLowerCase();
//                   });
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Button Tambah Warga
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   ElevatedButton(
//                     onPressed: _addWarga,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue[900],
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 15),
//                     ),
//                     child: const Text(
//                       'Tambah Warga',
//                       style: TextStyle(
//                         fontFamily: 'Montserrat',
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Tabel Data Warga
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Table(
//                   columnWidths: const {
//                     0: FixedColumnWidth(35),
//                     1: FixedColumnWidth(100),
//                     2: FixedColumnWidth(100),
//                     3: FixedColumnWidth(100),
//                     4: FixedColumnWidth(150),
//                     5: FixedColumnWidth(50),
//                     6: FixedColumnWidth(50),
//                     7: FixedColumnWidth(80),
//                     8: FixedColumnWidth(100),
//                   },
//                   children: [
//                     const TableRow(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('No',
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('Nama KK',
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('NIK KK',
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('Jumlah Anggota',
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('Alamat',
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('RT',
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('RW',
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('Aksi',
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                         ),
//                       ],
//                     ),
//                     ...filteredData.asMap().entries.map((entry) {
//                       int index = entry.key;
//                       var warga = entry.value;
//                       return TableRow(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('${index + 1}'),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(warga['namakk']),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(warga['nikkk']),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('${warga['anggota']}'),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(warga['alamat']),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(warga['rt']),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(warga['rw']),
//                           ),
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
//                             ],
//                           ),
//                         ],
//                       );
//                     }).toList(),
//                   ],
//                 ),
//               ),

//               // Summary total warga
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text('Total Kartu Keluarga',
//                       style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text(
//                       '${filteredData.length} Kartu Keluarga'), // Displaying the filtered count
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tambahdatakk_screen.dart';

class DataKartuKeluargaScreen extends StatefulWidget {
  const DataKartuKeluargaScreen({super.key});

  @override
  _DataKartuKeluargaScreenState createState() =>
      _DataKartuKeluargaScreenState();
}

class _DataKartuKeluargaScreenState extends State<DataKartuKeluargaScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  Future<List<Map<String, dynamic>>> _fetchDataKartuKeluarga() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('kartu_keluarga').get();
      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  void _addWarga() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DataKartuKeluargaForm()),
    ).then((_) => setState(() {})); // Refresh data after returning
  }

  void _deleteWarga(String docId) async {
    await FirebaseFirestore.instance
        .collection('kartu_keluarga')
        .doc(docId)
        .delete();
    setState(() {}); // Refresh data after deletion
  }

  void _editWarga(String docId, Map<String, dynamic> currentData) {
    TextEditingController nomorkkController =
        TextEditingController(text: currentData['NomorKK']);
    TextEditingController namakkController =
        TextEditingController(text: currentData['NamaKK']);
    TextEditingController jumlahAnggotaController =
        TextEditingController(text: currentData['JumlahAnggota'].toString());
    TextEditingController alamatController =
        TextEditingController(text: currentData['Alamat']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Data Kartu Keluarga"),
          content: SingleChildScrollView(
            // Menambahkan ScrollView untuk menghindari overflow jika keyboard muncul
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomorkkController,
                  decoration: const InputDecoration(labelText: 'Nomor KK'),
                  autofocus:
                      true, // Mengaktifkan fokus otomatis pada text field pertama
                ),
                TextField(
                  controller: namakkController,
                  decoration: const InputDecoration(labelText: 'Nama KK'),
                ),
                TextField(
                  controller: jumlahAnggotaController,
                  decoration:
                      const InputDecoration(labelText: 'Jumlah Anggota'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: alamatController,
                  decoration: const InputDecoration(labelText: 'Alamat'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  if (nomorkkController.text.isEmpty ||
                      namakkController.text.isEmpty ||
                      jumlahAnggotaController.text.isEmpty ||
                      alamatController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Semua bidang wajib diisi!"),
                      ),
                    );
                    return;
                  }
                  await FirebaseFirestore.instance
                      .collection('kartu_keluarga')
                      .doc(docId)
                      .update({
                    'NomorKK': nomorkkController.text,
                    'NamaKK': namakkController.text,
                    'JumlahAnggota': int.parse(jumlahAnggotaController.text),
                    'Alamat': alamatController.text,
                  });
                  Navigator.of(context).pop();
                  setState(() {}); // Refresh data after update
                } catch (e) {
                  print('Error updating document: $e');
                }
              },
              child: const Text("Simpan"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Batal"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Selamat Datang CekWarga!'),
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
                setState(() {}); // Refresh data on press
              },
            ),
          ]),
      backgroundColor: Color.fromARGB(255, 200, 227, 255),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchDataKartuKeluarga(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada data Kartu Keluarga"));
          }

          final dataKartuKeluarga = snapshot.data!;
          final filteredData = dataKartuKeluarga.where((warga) {
            return warga['NamaKK']
                .toString()
                .toLowerCase()
                .contains(_searchQuery);
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data Kartu Keluarga',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Cari Kartu Keluarga',
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

                // Button Tambah Warga
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _addWarga,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                      ),
                      child: const Text(
                        'Tambah Warga',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Tabel Data Warga
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(35),
                      1: FixedColumnWidth(100),
                      2: FixedColumnWidth(100),
                      3: FixedColumnWidth(150),
                      4: FixedColumnWidth(80),
                      5: FixedColumnWidth(80),
                      6: FixedColumnWidth(80),
                    },
                    children: [
                      const TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('No',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Nomor KK',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Nama KK',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Jumlah Anggota',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Alamat',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Aksi',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      ...filteredData.asMap().entries.map((entry) {
                        int index = entry.key;
                        var warga = entry.value;
                        return TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${index + 1}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(warga['NomorKK']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(warga['NamaKK']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${warga['JumlahAnggota']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(warga['Alamat']),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () =>
                                      _editWarga(warga['id'], warga),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => _deleteWarga(warga['id']),
                                ),
                              ],
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Kartu Keluarga',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('${filteredData.length} Kartu Keluarga'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
