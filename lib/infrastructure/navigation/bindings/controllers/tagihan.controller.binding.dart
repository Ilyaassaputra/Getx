import 'package:get/get.dart';

import '../../../../presentation/tagihan/controllers/tagihan.controller.dart';

class TagihanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TagihanController>(
      () => TagihanController(),
    );
  }
}
