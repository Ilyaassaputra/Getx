import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onProfilePressed;
  final VoidCallback onLogoutPressed;
  final VoidCallback onChangeThemePressed;
  final VoidCallback onChangeDataSantri;
  final VoidCallback onChangeDataTagihan;

  const CustomDrawer({
    Key? key,
    required this.onProfilePressed,
    required this.onLogoutPressed,
    required this.onChangeThemePressed,
    required this.onChangeDataSantri,
    required this.onChangeDataTagihan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: onProfilePressed,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: onLogoutPressed,
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Change Theme'),
            onTap: onChangeThemePressed,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cari Santri'),
            onTap: onChangeDataSantri,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Tambah Tagihan'),
            onTap: onChangeDataTagihan,
          ),
        ],
      ),
    );
  }
}
