import 'package:get/get.dart';
import 'package:japark/controllers/parkingcontroller.dart';
import 'package:japark/database/database.dart';
import 'package:japark/models/parking.dart';
import 'package:japark/views/homepage.dart';

class ForgetController extends GetxController {
  MyDatabase database = MyDatabase.instance;
  ParkingController parkingController = Get.find();
  String? question;
  String? answer;
  Parking? parking;
  Future<void> getQuestion(String email) async {
    parking = await database.getParkingByEmail(email);
    if (parking != null) {
      question = parking!.question;
      answer = parking!.answer;
      update();
    } else {
      question = null;
      answer = null;
    }
  }

  void check(String t) {
    if (answer!.toLowerCase() == t.toLowerCase()) {
      Get.offAll(HomePage());
      parkingController.parking = parking!;
    }
  }
}
