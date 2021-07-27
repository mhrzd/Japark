
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
  TextEditingController floors = TextEditingController();
  TextEditingController enterCharge = TextEditingController();
  TextEditingController chargePH = TextEditingController();
  TextEditingController answer = TextEditingController();
  TextEditingController question = TextEditingController();

  Future<int> signUp() async {
    Map<String, dynamic> row = {
      MyDatabase.email: email.text.toLowerCase(),
      MyDatabase.password: pass.text,
      MyDatabase.parkingName: parkingName.text,
      MyDatabase.capacity: int.parse(capacity.text),
      MyDatabase.enterCharge: int.parse(enterCharge.text),
      MyDatabase.chargePerHour: int.parse(chargePH.text),
      MyDatabase.floors: int.parse(floors.text),
      MyDatabase.occupied: 0,
      MyDatabase.answer: answer.text,
      MyDatabase.question: question.text
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
