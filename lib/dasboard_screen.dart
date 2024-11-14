import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/datakartukeluarga_screen.dart';
import 'package:myapp/datawarga_screen.dart';
import 'package:myapp/datauser_screen.dart';
import 'package:myapp/datamutasi_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final CollectionReference wargaCollection =
      FirebaseFirestore.instance.collection('warga');
  final CollectionReference kartuKeluargaCollection =
      FirebaseFirestore.instance.collection('kartu_keluarga');
  final CollectionReference mutasiCollection =
      FirebaseFirestore.instance.collection('mutasi');

  int totalWarga = 0;
  int jumlahLaki = 0;
  int jumlahPerempuan = 0;
  int wargaDibawah17 = 0;
  int wargaDiatas17 = 0;
  int totalKartuKeluarga = 0;
  int totalMutasi = 0;
  int mutasiLaki = 0;
  int mutasiPerempuan = 0;

  @override
  void initState() {
    super.initState();
    _fetchStatistics();
    _fetchKartuKeluargaData();
    _fetchMutasiData();
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
      wargaDibawah17 = allData.where((doc) => doc['Umur'] < 17).length;
      wargaDiatas17 = allData.where((doc) => doc['Umur'] >= 17).length;
    });
  }

  Future<void> _fetchKartuKeluargaData() async {
    final QuerySnapshot snapshot = await kartuKeluargaCollection.get();
    setState(() {
      totalKartuKeluarga = snapshot.docs.length;
    });
  }

  Future<void> _fetchMutasiData() async {
    final QuerySnapshot snapshot = await mutasiCollection.get();
    final allData = snapshot.docs;

    setState(() {
      totalMutasi = allData.length;
      mutasiLaki =
          allData.where((doc) => doc['JenisKelamin'] == 'Laki-Laki').length;
      mutasiPerempuan =
          allData.where((doc) => doc['JenisKelamin'] == 'Perempuan').length;
    });
  }

  Widget buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selamat Datang, CekWarga!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DataUserPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(94, 143, 191, 206),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Kartu Data Warga
                Card(
                  child: Padding(
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
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildInfoRow('Total Warga', '$totalWarga orang'),
                              buildInfoRow(
                                  'Jumlah Laki-Laki', '$jumlahLaki orang'),
                              buildInfoRow(
                                  'Jumlah Perempuan', '$jumlahPerempuan orang'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DataWargaScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            foregroundColor:
                                const Color.fromARGB(255, 243, 241, 241),
                          ),
                          child: const Text('Detail'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Kartu Data Kartu Keluarga
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Data Kartu Keluarga',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Kartu Keluarga',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('$totalKartuKeluarga Kartu Keluarga'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DataKartuKeluargaScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            foregroundColor:
                                const Color.fromARGB(255, 250, 248, 248),
                          ),
                          child: const Text('Detail'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Kartu Data Mutasi
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Data Mutasi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Terdapat $totalMutasi data mutasi. $mutasiLaki di antaranya laki-laki, dan $mutasiPerempuan perempuan.',
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DataMutasiPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            foregroundColor:
                                const Color.fromARGB(255, 250, 247, 247),
                          ),
                          child: const Text('Detail'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
