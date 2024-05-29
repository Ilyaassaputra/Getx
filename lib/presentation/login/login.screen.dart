import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/login.controller.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final thisController = Get.put(LoginController());
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
          IconButton(
            onPressed: () {
              // c.changeTheme();
            },
            icon: Icon(Icons.color_lens), // Ikon untuk mengganti tema
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 150),
              Image.asset(
                'assets/images/logoaka.jpg',
                width: 150,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat Datang di \nSimouaka 👋',
                          style: TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        thisController.username.value =
                            value; // Update nilai username pada controller
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),

                    SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) {
                        thisController.password.value =
                            value; // Update nilai password pada controller
                      },
                      // obscureText: !c.isPasswordVisible.value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),

                    SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Text(
                    //       'Lupa Password',
                    //       style: TextStyle(
                    //         fontSize: 14,
                    //         color: Colors.blue,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          thisController.onLoginButtonPressed();
                        },
                        child: Text(
                          'Masuk',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Apakah anda belum memiliki akun ? ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
