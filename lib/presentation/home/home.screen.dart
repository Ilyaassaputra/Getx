import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_test/presentation/login/login.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({required this.nama});
  final String nama;
  // required nama

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simouaka',
          style: TextStyle(
            fontFamily: 'Peanut Butter',
            fontSize: 30,
          ),
        ),
        actions: [
          actionBar(),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi, Selamat Datang 👋',
                                  style: TextStyle(
                                    fontFamily: 'roboto',
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  nama,
                                  style: TextStyle(
                                      fontFamily: 'roboto',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildCard(Icons.my_library_books_outlined,
                                          "Momerandum Of Understanding", () {
                                        // Get.to(() => MouScreen());
                                      }),
                                      buildCard(Icons.my_library_books,
                                          "Momerandum Of \nAgreement", () {
                                        // Get.to(() => MoaScreen());
                                      }),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildCard(Icons.post_add,
                                          "Input Kegiatan \nDokumen", () {
                                        // Get.to(() => InputKegiatanScreen());
                                      }),
                                      buildCard(Icons.account_circle,
                                          "Lihat Token", () {}),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Develop by IT, ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          'AKN Putra Sang Fajar!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class actionBar extends StatelessWidget {
  const actionBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Tambahkan logika untuk menu Profile di sini
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Get.offAll(() => LoginScreen());
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('Change Theme'),
              onTap: () {},
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.panorama_fish_eye_sharp),
              title: Text('Lihat Token'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? token = prefs.getString('token');
                // Lakukan logika sesuai dengan nilai token
                if (token != null) {
                  Get.dialog(AlertDialog(
                      title: Text('Token'),
                      content: Text(token),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ]));
                  // Lanjutkan dengan logika Anda di sini
                } else {
                  // Jika token tidak ada, mungkin pengguna belum login
                  // Anda dapat menangani ini dengan cara yang sesuai
                }
              },
            ),
          ),
        ];
      },
    );
  }
}

Widget buildCard(IconData icon, String label, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 5,
      child: Container(
        width: 200,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
            ),
            SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'roboto'),
            ),
          ],
        ),
      ),
    ),
  );
}
