import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/parkingcontroller.dart';
import 'package:japark/database/database.dart';
import 'package:japark/models/parking.dart';

class LoginController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  MyDatabase database = MyDatabase.instance;
  ParkingController parkingController = Get.find();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  
  Future<bool> login() async {
    var r = await database.login(email.text.toLowerCase(), pass.text);
    if (r != null) {
      parkingController.parking = Parking.fromJson(r);
      return true;
    } else {
      Fluttertoast.showToast(msg: 'ایمیل یا رمز عبور نادرست است');
      return false;
    }
  }
}
