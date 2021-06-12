import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japark/views/loginpage.dart';

import 'controllers/themecontroller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ThemeController themeController = ThemeController();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeController.theme,
      home: LoginPage(),
    );
  }
}
