import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import untuk membaca asset

class LoadJSONExample extends StatefulWidget {
  @override
  _LoadJSONExampleState createState() => _LoadJSONExampleState();
}

class _LoadJSONExampleState extends State<LoadJSONExample> {
  List<dynamic> data = []; // Inisialisasi list untuk menyimpan data
  int dataLength = 0;
  @override
  void initState() {
    super.initState();
    _loadData(); // Panggil fungsi untuk memuat data saat widget diinisialisasi
  }

  Future<void> _loadData() async {
    // Membaca file JSON dari asset
    final String jsonString =
        await rootBundle.loadString('assets/dummy_data/data_toko_dummy.json');

    // Decode JSON string ke dalam list dynamic
    setState(() {
      // count the data length
      data = jsonDecode(jsonString);

      dataLength = data.length;

      debugPrint('Data Length: $dataLength');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Toko'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Data Penjualan $dataLength',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Center(
              child: data.isEmpty
                  // Tampilkan pesan loading jika data belum dimuat
                  // Jika dalam 5 detik data belum dimuat, tampilkan pesan error
                  ? FutureBuilder(
                      future: Future.delayed(Duration(seconds: 5)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Text('Gagal memuat data');
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text('Memuat data...'),
                          ],
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.shopping_cart),
                            ),
                            title: Text(
                              item['Jenis_Item'] ?? 'Data gagal dimuat',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Informasi ditampilkan dalam satu baris dengan ikon
                                // _buildRowInfo(Icons.local_offer, 'No. Penjualan',
                                //     item['No_Penjualan']),
                                // _buildRowInfo(Icons.format_list_numbered, 'Jumlah',
                                //     item['Jumlah']),
                                // _buildRowInfo(Icons.monetization_on, 'Harga Satuan',
                                //     item['Harga_Satuan']),
                                // _buildRowInfo(Icons.attach_money, 'Total Harga',
                                //     item['Total_Harga']),
                                // _buildRowInfo(Icons.date_range, 'Tanggal',
                                //     item['Tanggal']),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.more_vert,
                                  color: Colors.green, size: 24),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun baris informasi dengan ikon dan teks
  Widget _buildRowInfo(IconData icon, String label, dynamic value) {
    return Padding(
      // Tambahkan padding di setiap baris
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(icon, size: 16),
          SizedBox(width: 8), // Spasi lebih besar
          Text('$label: $value'),
        ],
      ),
    );
  }
}
