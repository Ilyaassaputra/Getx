import 'package:get/get.dart';

import '../../../../presentation/data_pendaftar/controllers/data_pendaftar.controller.dart';

class DataPendaftarControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataPendaftarController>(
      () => DataPendaftarController(),
    );
  }
}
