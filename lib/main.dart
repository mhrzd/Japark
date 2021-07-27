import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/parkingcontroller.dart';
import 'package:japark/views/loginpage.dart';

import 'package:japark/controllers/themecontroller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ParkingController parkingController = Get.put(ParkingController());
  ThemeController themeController = ThemeController();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeController.theme,
      home: LoginPage(),
    );
  }
}
