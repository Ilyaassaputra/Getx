import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TagihanController extends GetxController {
  var nominalTagihan = ''.obs;

  Future<void> fetchNominalTagihan(int id) async {
    final url = 'http://127.0.0.1:8000/api/getDataNominal?id=$id';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message']) {
          nominalTagihan.value = data['data']['nominal_tagihan'];
        } else {
          nominalTagihan.value = 'Rp. 0';
        }
      } else {
        nominalTagihan.value = 'Rp. 0';
      }
    } catch (e) {
      nominalTagihan.value = 'Rp. 0';
    }
  }

  Future<bool> simpanData(int jenisTagihanId, String? bulan, String? tahunAjaran, String nominalTagihan) async {
    final url = 'http://127.0.0.1:8000/api/buat-tagihan?jenis_tagihan_id=$jenisTagihanId&bulan=${bulan ?? ''}&thn_ajaran=${tahunAjaran ?? ''}&nominal_tagihan=$nominalTagihan';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 200) {
          Get.snackbar('Success', data['message'], snackPosition: SnackPosition.BOTTOM);
          return true;
        } else {
          Get.snackbar('Error', 'Failed to save data', snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar('Error', 'Failed to save data', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save data', snackPosition: SnackPosition.BOTTOM);
    }
    return false;
  }
}
