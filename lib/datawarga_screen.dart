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
      MaterialPageRoute(builder: (context) => const DataWargaForm()),
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
                        }),
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
