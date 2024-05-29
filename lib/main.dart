import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  // Set the initial route to Routes.LOGIN
  var initialRoute = Routes.LOGIN; // Directly setting the initial route to LOGIN
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  Main(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: initialRoute,
      getPages: Nav.routes,
    );
  }
}
