import 'package:get/get.dart';

import '../../../../presentation/santri/controllers/santri.controller.dart';

class SantriControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SantriController>(
      () => SantriController(),
    );
  }
}
