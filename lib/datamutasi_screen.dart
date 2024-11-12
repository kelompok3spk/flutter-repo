// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:myapp/galeriinput_screen.dart';

// class DataMutasiPage extends StatefulWidget {
//   @override
//   _DataMutasiPageState createState() => _DataMutasiPageState();
// }

// class _DataMutasiPageState extends State<DataMutasiPage> {
//   final CollectionReference mutasiCollection = FirebaseFirestore.instance.collection('mutasi');
//   int totalWarga = 0;
//   int jumlahLakiLaki = 0;
//   int jumlahPerempuan = 0;
//   int wargaDibawah17 = 0;
//   int wargaDiatas17 = 0;

//   @override
//   void initState() {
//     super.initState();
//     _fetchStatistics();
//   }

//   Future<void> _fetchStatistics() async {
//     final querySnapshot = await mutasiCollection.get();
//     final data = querySnapshot.docs;

//     int total = data.length;
//     int lakiLaki = 0;
//     int perempuan = 0;
//     int dibawah17 = 0;
//     int diatas17 = 0;

//     for (var doc in data) {
//       final mutasiData = doc.data() as Map<String, dynamic>;
//       final gender = mutasiData['JenisKelamin'] ?? '';
//       final usia = int.tryParse(mutasiData['Usia'] ?? '0') ?? 0;

//       if (gender == 'L') {
//         lakiLaki++;
//       } else if (gender == 'P') {
//         perempuan++;
//       }

//       if (usia < 17) {
//         dibawah17++;
//       } else {
//         diatas17++;
//       }
//     }

//     setState(() {
//       totalWarga = total;
//       jumlahLakiLaki = lakiLaki;
//       jumlahPerempuan = perempuan;
//       wargaDibawah17 = dibawah17;
//       wargaDiatas17 = diatas17;
//     });
//   }

//   Widget buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label),
//           Text(value),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Selamat Datang, CekWarga!'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _fetchStatistics,
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           color: Color.fromARGB(24, 33, 149, 243),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'List Warga Mutasi',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue[900],
//                       foregroundColor: Colors.white,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => GaleriInputPage()),
//                       );
//                     },
//                     child: const Text('Lampiran'),
//                   ),
//                   const SizedBox(
//                     width: 120,
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Cari',
//                         prefixIcon: Icon(Icons.search),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: mutasiCollection.snapshots(),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     final data = snapshot.data!.docs;
//                     return SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         columns: const [
//                           DataColumn(label: Text('NIK')),
//                           DataColumn(label: Text('Nama Mutasi')),
//                           DataColumn(label: Text('L/P')),
//                           DataColumn(label: Text('Alamat')),
//                           DataColumn(label: Text('Usia')),
//                           DataColumn(label: Text('Pendidikan')),
//                           DataColumn(label: Text('Pekerjaan')),
//                           DataColumn(label: Text('Nikah')),
//                           DataColumn(label: Text('Tanggal')),  // Kolom Tanggal baru
//                           DataColumn(label: Text('Status')),
//                         ],
//                         rows: data.map((doc) {
//                           final mutasiData = doc.data() as Map<String, dynamic>;
//                           return DataRow(
//                             cells: [
//                               DataCell(Text(mutasiData['NIK'] ?? '')),
//                               DataCell(Text(mutasiData['Nama'] ?? '')),
//                               DataCell(Text(mutasiData['JenisKelamin'] ?? '')),
//                               DataCell(Text(mutasiData['Alamat'] ?? '')),
//                               DataCell(Text(mutasiData['Usia'] ?? '')),
//                               DataCell(Text(mutasiData['Pendidikan'] ?? '')),
//                               DataCell(Text(mutasiData['Pekerjaan'] ?? '')),
//                               DataCell(Text(mutasiData['StatusNikah'] ?? '')),
//                               DataCell(Text(mutasiData['TanggalMutasi'] ?? '')), // Data tanggal
//                               DataCell(Text(mutasiData['StatusMutasi'] ?? '')),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const Divider(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     buildInfoRow('Total Warga', '$totalWarga orang'),
//                     buildInfoRow('Jumlah Laki-Laki', '$jumlahLakiLaki orang'),
//                     buildInfoRow('Jumlah Perempuan', '$jumlahPerempuan orang'),
//                     buildInfoRow('Warga < 17 tahun', '$wargaDibawah17 orang'),
//                     buildInfoRow('Warga >= 17 tahun', '$wargaDiatas17 orang'),
//                   ],
//                 ),
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
import 'package:myapp/galeriinput_screen.dart';

class DataMutasiPage extends StatefulWidget {
  @override
  _DataMutasiPageState createState() => _DataMutasiPageState();
}

class _DataMutasiPageState extends State<DataMutasiPage> {
  final CollectionReference mutasiCollection =
      FirebaseFirestore.instance.collection('mutasi');
  int totalWarga = 0;
  int jumlahLakiLaki = 0;
  int jumlahPerempuan = 0;
  int wargaDibawah17 = 0;
  int wargaDiatas17 = 0;

  @override
  void initState() {
    super.initState();
    _fetchStatistics();
  }

  Future<void> _fetchStatistics() async {
    final querySnapshot = await mutasiCollection.get();
    final data = querySnapshot.docs;

    int total = data.length;
    int lakiLaki = 0;
    int perempuan = 0;
    int dibawah17 = 0;
    int diatas17 = 0;

    for (var doc in data) {
      final mutasiData = doc.data() as Map<String, dynamic>;
      final gender = mutasiData['JenisKelamin'] ?? '';
      final usia = int.tryParse(mutasiData['Usia'] ?? '0') ?? 0;

      if (gender == 'Laki-Laki') {
        lakiLaki++;
      } else if (gender == 'Perempuan') {
        perempuan++;
      }

      if (usia < 17) {
        dibawah17++;
      } else {
        diatas17++;
      }
    }

    setState(() {
      totalWarga = total;
      jumlahLakiLaki = lakiLaki;
      jumlahPerempuan = perempuan;
      wargaDibawah17 = dibawah17;
      wargaDiatas17 = diatas17;
    });
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selamat Datang, CekWarga!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchStatistics,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(24, 33, 149, 243),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'List Warga Mutasi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GaleriInputPage()),
                      );
                    },
                    child: const Text('Lampiran'),
                  ),
                  const SizedBox(
                    width: 120,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: mutasiCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final data = snapshot.data!.docs;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('NIK')),
                          DataColumn(label: Text('Nama Mutasi')),
                          DataColumn(label: Text('L/P')),
                          DataColumn(label: Text('Alamat')),
                          DataColumn(label: Text('Usia')),
                          DataColumn(label: Text('Pendidikan')),
                          DataColumn(label: Text('Pekerjaan')),
                          DataColumn(label: Text('Nikah')),
                          DataColumn(
                              label: Text('Tanggal')), // Kolom Tanggal baru
                          DataColumn(label: Text('Status')),
                        ],
                        rows: data.map((doc) {
                          final mutasiData = doc.data() as Map<String, dynamic>;
                          return DataRow(
                            cells: [
                              DataCell(Text(mutasiData['NIK'] ?? '')),
                              DataCell(Text(mutasiData['NamaMutasi'] ?? '')),
                              DataCell(Text(mutasiData['JenisKelamin'] ?? '')),
                              DataCell(Text(mutasiData['Alamat'] ?? '')),
                              DataCell(Text(mutasiData['Usia'] ?? '')),
                              DataCell(Text(mutasiData['Pendidikan'] ?? '')),
                              DataCell(Text(mutasiData['Pekerjaan'] ?? '')),
                              DataCell(Text(mutasiData['StatusNikah'] ?? '')),
                              DataCell(Text(mutasiData['TanggalMutasi'] ??
                                  '')), // Data tanggal
                              DataCell(Text(mutasiData['StatusMutasi'] ?? '')),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoRow('Total Warga', '$totalWarga orang'),
                    buildInfoRow('Jumlah Laki-Laki', '$jumlahLakiLaki orang'),
                    buildInfoRow('Jumlah Perempuan', '$jumlahPerempuan orang'),
                    buildInfoRow('Warga < 17 tahun', '$wargaDibawah17 orang'),
                    buildInfoRow('Warga >= 17 tahun', '$wargaDiatas17 orang'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
