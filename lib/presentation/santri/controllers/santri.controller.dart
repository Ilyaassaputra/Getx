import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SantriController extends GetxController {
  var isLoading = false.obs;
  var santriList = <Map<String, dynamic>>[].obs;
  var selectedSantri = {}.obs;
  var tagihanList = <Map<String, dynamic>>[].obs;

  Future<void> searchSantri(String nama) async {
    isLoading.value = true;
    final url =
        'http://127.0.0.1:8000/api/getDataSantriByNamed?nama_santri=$nama';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message']) {
          santriList.value = List<Map<String, dynamic>>.from(data['data']);
        } else {
          santriList.clear();
        }
      } else {
        santriList.clear();
      }
    } catch (e) {
      santriList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void clearSantriList() {
    santriList.clear();
  }

  Future<void> fetchSantriDetail(int id) async {
    isLoading.value = true;
    final url = 'http://127.0.0.1:8000/api/getDataSantriById?id=$id';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message']) {
          tagihanList.value =
              List<Map<String, dynamic>>.from(data['data']['tagihans']);
          // Remove other santri from the list
          santriList.removeWhere((santri) => santri['id'] != id);
        } else {
          tagihanList.clear();
        }
      } else {
        tagihanList.clear();
      }
    } catch (e) {
      tagihanList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> makePayment(String? paymentMethod, int santriId) async {
    if (paymentMethod != null) {
      // URL API untuk melakukan pembayaran
      var apiUrl = Uri.parse(
          'http://127.0.0.1:8000/api/bayar?id=$santriId&metode=$paymentMethod');

      try {
        // Melakukan permintaan POST ke URL API
        var response = await http.post(apiUrl);

        if (response.statusCode == 200) {
          // Parsing respons JSON
          var responseData = json.decode(response.body);

          // Memeriksa apakah pesan adalah true
          if (responseData['message'] == true) {
            // Menampilkan Snackbar jika pesan true
            Get.snackbar('Success', 'Data berhasil diupdate');
          } else {
            // Menampilkan pesan respons jika tidak true
            Get.snackbar('Error', responseData['message']);
          }
        } else {
          // Gagal melakukan pembayaran
          print(
              'Gagal melakukan pembayaran. Status code: ${response.statusCode}');
          // Tambahkan penanganan kesalahan lain jika diperlukan
        }
      } catch (e) {
        // Tangani kesalahan jika ada
        print('Terjadi kesalahan: $e');
      }
    } else {
      // Jika metode pembayaran kosong
      print('Metode pembayaran tidak valid');
    }
  }
}
