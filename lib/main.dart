import 'package:flutter/material.dart';

import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  


  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily: 'Montserrat', // 🔹 Set Montserrat sebagai font default
      ),
    home: SplashScreen(),
  ));
}
