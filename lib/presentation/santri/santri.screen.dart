import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/presentation/login/login.screen.dart';
import 'package:getx_test/presentation/screens.dart';
import 'controllers/santri.controller.dart';

class SantriScreen extends StatefulWidget {
  @override
  _SantriScreenState createState() => _SantriScreenState();
}

class _SantriScreenState extends State<SantriScreen> {
  final SantriController _controller = Get.put(SantriController());
  final _formKey = GlobalKey<FormState>();
  final _namaSantriController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _selectedPaymentMethod;
  File? _selectedImage;

  @override
  void dispose() {
    _namaSantriController.dispose();
    super.dispose();
  }

  void _refreshPage() {
    setState(() {
      _namaSantriController.clear(); // Bersihkan input nama santri
      _controller.clearSantriList(); // Bersihkan daftar santri
      _controller.tagihanList.clear(); // Bersihkan daftar tagihan
    });
  }

  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _showPaymentDialog(int? idTagihan, int? idSantri) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Pembayaran'),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      value: _selectedPaymentMethod,
                      items: ['Cash', 'Transfer'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPaymentMethod = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Metode Pembayaran',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pilih metode pembayaran';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Periksa apakah _selectedPaymentMethod tidak null
                          if (_selectedPaymentMethod != null) {
                            // Periksa apakah idTagihan tidak null sebelum memanggil _makePayment
                            int tagihanId = idTagihan ??
                                -1; // Menggunakan nilai default -1 jika idTagihan null
                            if (tagihanId != -1) {
                              _controller.makePayment(
                                  _selectedPaymentMethod!, tagihanId);
                              print([_selectedPaymentMethod, tagihanId]);
                              Navigator.of(context).pop(); // Tutup dialog
                            } else {
                              // Tampilkan pesan kesalahan jika idTagihan null
                              print('ID tagihan null');
                            }
                          } else {
                            // Tampilkan pesan kesalahan jika metode pembayaran tidak dipilih
                            print('Metode pembayaran tidak dipilih');
                          }
                        }
                        _controller.fetchSantriDetail(
                          idSantri ?? -1,
                        );
                      },
                      child: Text('Bayar'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Al Hunnain.',
          style: TextStyle(
            fontFamily: 'Peanut Butter',
            fontSize: 30,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Get.offAll(() => LoginScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('Change Theme'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cari Data Santri',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _namaSantriController,
                    decoration: InputDecoration(
                      labelText: 'Nama Santri',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama Santri tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _controller.searchSantri(_namaSantriController.text);
                      }
                    },
                    child: Text('Cari'),
                  ),
                  SizedBox(width: 10), // Tambahkan jarak antara tombol
                  ElevatedButton(
                    onPressed: () {
                      _refreshPage();
                    },
                    child: Icon(Icons.refresh),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              if (_controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_controller.santriList.isEmpty) {
                return Center(
                    child: Text('Tidak ada data santri yang ditemukan'));
              } else {
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daftar Santri',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _controller.santriList.length,
                          itemBuilder: (context, index) {
                            final santri = _controller.santriList[index];
                            return ListTile(
                              title: Text(santri['nama']),
                              subtitle: Text(santri['sekolah_id'].toString()),
                              onTap: () {
                                _controller.fetchSantriDetail(santri['id']);
                              },
                            );
                          },
                        ),
                      ),
                      if (_controller.tagihanList.isNotEmpty)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Detail Santri Tagihan',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                  child: ListView.builder(
                                itemCount: _controller.tagihanList.length,
                                itemBuilder: (context, index) {
                                  final tagihan =
                                      _controller.tagihanList[index];
                                  return ListTile(
                                    title: Text(
                                        'Jenis Tagihan: ${tagihan['jenis_tagihan_id']}'),
                                    subtitle: Column(
                                      children: [
                                        Text(
                                            'Nominal Tagihan: ${tagihan['nominal_tagihan']}'),
                                        Text(
                                            'Status Pembayaran: ${tagihan['status_pembayaran']}'),
                                      ],
                                    ),
                                    trailing: tagihan['status_pembayaran'] ==
                                            'Belum Bayar'
                                        ? ElevatedButton(
                                            onPressed: () {
                                              _showPaymentDialog(tagihan['id'],
                                                  tagihan['santri_id']);
                                            },
                                            child: Text('Bayar'),
                                          )
                                        : null,
                                  );
                                },
                              )),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
