import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/parkingcontroller.dart';
import 'package:japark/database/database.dart';
import 'package:japark/models/parking.dart';

class SignUpController extends GetxController {
  MyDatabase database = MyDatabase.instance;
  ParkingController parkingController = Get.find();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController repass = TextEditingController();
  TextEditingController parkingName = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController enterCharge = TextEditingController();
  TextEditingController chargePH = TextEditingController();
  TextEditingController answer = TextEditingController();
  TextEditingController question = TextEditingController();

  Future<int> signUp() async {
    Map<String, dynamic> row = {
      MyDatabase.Email: email.text.toLowerCase(),
      MyDatabase.Password: pass.text,
      MyDatabase.ParkingName: parkingName.text,
      MyDatabase.Capacity: int.parse(capacity.text),
      MyDatabase.EnterCharge: int.parse(enterCharge.text),
      MyDatabase.ChargePerHour: int.parse(chargePH.text),
      MyDatabase.Occupied: 0,
      MyDatabase.Answer: answer.text,
      MyDatabase.Question: question.text
    };
    int a = await database.addParking(row);
    var r = await database.login(email.text, pass.text);
    if (r != null) {
      parkingController.parking = Parking.fromJson(r);
    }

    return a;
  }

  Future<bool> checkEmail() async {
    var r = await database.getAllParkings();
    List<Parking> p = [];
    bool result = true;
    r.forEach((element) {
      p.add(Parking.fromJson(element));
    });
    p.forEach((element) {
      if (element.email == email.text) {
        result = false;
      }
    });
    return result;
  }
}
