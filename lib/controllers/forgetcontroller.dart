import 'package:get/get.dart';
import 'package:japark/controllers/parkingcontroller.dart';
import 'package:japark/database/database.dart';
import 'package:japark/models/parking.dart';
import 'package:japark/views/homepage.dart';

class ForgetController extends GetxController {
  MyDatabase database = MyDatabase.instance;
  ParkingController parkingController = Get.find();
  String? question;
  String? password;
  Parking? parking;
  void getQuestion(String email) async {
    parking = await database.getParkingByEmail(email);
    if (parking != null) {
      question = parking!.question;
      password = parking!.password;
      update();
    }
  }

  void check(String t) {
    if (password == t) {
      Get.offAll(HomePage());
      parkingController.parking = parking!;
    }
  }
}
