class Routes {
  static const HOME = '/home';
  static const LOGIN = '/login';

  // Other routes...

  static Future<String> get initialRoute async {
    // Any async logic to determine the initial route can go here
    // For this example, we return LOGIN
    return LOGIN;
  }
}
