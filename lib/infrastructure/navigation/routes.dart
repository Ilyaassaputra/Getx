class Routes {
  // Other routes...

  static Future<String> get initialRoute async {
    // Any async logic to determine the initial route can go here
    // For this example, we return LOGIN
    return SANTRI;
  }

  static const DATA_PENDAFTAR = '/data-pendaftar';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const TAGIHAN = '/tagihan';
  static const SANTRI = '/santri';
}
