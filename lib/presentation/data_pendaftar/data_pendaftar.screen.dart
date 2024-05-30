import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/data_pendaftar.controller.dart';

class DataPendaftarScreen extends GetView<DataPendaftarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DataPendaftarScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DataPendaftarScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
