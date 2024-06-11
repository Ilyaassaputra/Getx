import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/presentation/login/login.screen.dart';
import 'controllers/tagihan.controller.dart';

class TagihanScreen extends StatefulWidget {
  @override
  _TagihanScreenState createState() => _TagihanScreenState();
}

class _TagihanScreenState extends State<TagihanScreen> {
  final TagihanController _controller = Get.put(TagihanController());

  int? _selectedJenisTagihan;
  String? _selectedBulan;
  String? _selectedTahunAjaran;
  final _tahunAjaranController = TextEditingController();

  void _clearForm() {
    setState(() {
      _selectedJenisTagihan = null;
      _selectedBulan = null;
      _selectedTahunAjaran = null;
      _tahunAjaranController.clear();
      _controller.nominalTagihan.value = '';
    });
  }

  @override
  void dispose() {
    _tahunAjaranController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Tagihan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      labelText: 'Jenis Tagihan',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(value: 1, child: Text('Bulanan')),
                      DropdownMenuItem(value: 2, child: Text('Daftar Ulang')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedJenisTagihan = value;
                      });
                      if (value != null) {
                        _controller.fetchNominalTagihan(value);
                      }
                    },
                    value: _selectedJenisTagihan,
                  ),
                  SizedBox(height: 20),
                  if (_selectedJenisTagihan == 1)
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Bulan',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem(
                            value: 'Januari', child: Text('Januari')),
                        DropdownMenuItem(
                            value: 'Februari', child: Text('Februari')),
                        DropdownMenuItem(value: 'Maret', child: Text('Maret')),
                        DropdownMenuItem(value: 'April', child: Text('April')),
                        DropdownMenuItem(value: 'Mei', child: Text('Mei')),
                        DropdownMenuItem(value: 'Juni', child: Text('Juni')),
                        DropdownMenuItem(value: 'Juli', child: Text('Juli')),
                        DropdownMenuItem(
                            value: 'Agustus', child: Text('Agustus')),
                        DropdownMenuItem(
                            value: 'September', child: Text('September')),
                        DropdownMenuItem(
                            value: 'Oktober', child: Text('Oktober')),
                        DropdownMenuItem(
                            value: 'November', child: Text('November')),
                        DropdownMenuItem(
                            value: 'Desember', child: Text('Desember')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedBulan = value;
                        });
                      },
                      value: _selectedBulan,
                    ),
                  if (_selectedJenisTagihan == 1) SizedBox(height: 20),
                  if (_selectedJenisTagihan == 2)
                    TextFormField(
                      controller: _tahunAjaranController,
                      decoration: InputDecoration(
                        labelText: 'Tahun Ajaran',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _selectedTahunAjaran = value;
                      },
                    ),
                  if (_selectedJenisTagihan == 2) SizedBox(height: 20),
                  Obx(() => TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Nominal Tagihan',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: _controller.nominalTagihan.value,
                        key: Key(_controller
                            .nominalTagihan.value), // To force rebuild
                      )),
                ],
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () async {
                  if (_selectedJenisTagihan != null) {
                    bool success = await _controller.simpanData(
                      _selectedJenisTagihan!,
                      _selectedBulan,
                      _selectedTahunAjaran,
                      _controller.nominalTagihan.value,
                    );
                    if (success) {
                      _clearForm();
                    }
                  } else {
                    Get.snackbar('Error', 'Jenis Tagihan harus dipilih',
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                child: Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
