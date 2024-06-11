import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_test/presentation/login/login.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({required this.nama});
  final String nama;

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
        actions: [
          actionBar(),
        ],
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
                // Handle Profile
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
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.panorama_fish_eye_sharp),
              title: Text('Lihat Token'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? token = prefs.getString('token');
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
                    ],
                  ));
                }
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Welcome'),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildDashboardCard(
                    icon: Icons.person,
                    title: 'Total Pendaftar',
                    value: '1',
                    color: Colors.blue,
                  ),
                  buildDashboardCard(
                    icon: Icons.person_outline,
                    title: 'Total Santri',
                    value: '0',
                    color: Colors.blue,
                  ),
                  buildDashboardCard(
                    icon: Icons.bar_chart,
                    title: 'Total',
                    value: '\$1,345',
                    color: Colors.green,
                  ),
                  buildDashboardCard(
                    icon: Icons.check_circle,
                    title: 'Total',
                    value: '576',
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDashboardCard(
      {required IconData icon,
      required String title,
      required String value,
      required Color color}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title),
        trailing: Text(value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                // Handle Profile
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
              title: Text('ANCOK'),
              onTap: () {},
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.currency_bitcoin),
              title: Text('Tagihan'),
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
                    ],
                  ));
                }
              },
            ),
          ),
        ];
      },
    );
  }
}
