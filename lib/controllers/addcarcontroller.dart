import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/parkingcontroller.dart';
import 'package:japark/database/database.dart';

class AddCarController extends GetxController {
  MyDatabase database = MyDatabase.instance;
  ParkingController parkingController = Get.find();
  TextEditingController plate1 = TextEditingController();
  TextEditingController plate2 = TextEditingController();
  TextEditingController plate3 = TextEditingController();
  TextEditingController plate4 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController carType = TextEditingController();
  TextEditingController duration = TextEditingController();

  Future<bool> addCar() async {
    
      parkingController.setOccupied(parkingController.parking!.occupied! + 1);
      await database.setParkingOccupied(
          {MyDatabase.occupied: parkingController.parking!.occupied},
          parkingController.parking!.parkingId!);
      return true;
    
  }

  void clear() {
    plate1.text = '';
    plate2.text = '';
    plate3.text = '';
    plate4.text = '';
    phone.text = '';
    carType.text = '';
    name.text = '';
    duration.text = '';
  }

  String? setFloor() {
    int d = int.parse(duration.text);
    if (d >= 300) {
      String g = parkingController.parking!.floors!.toString();
      return g;
    } else {
      for (int i = parkingController.parking!.floors! - 1; i >= 0; i--) {
        if (d >= (300 / (parkingController.parking!.floors!-1) * i)) {
          return (i + 1).toString();
        }
      }
    }
  }
}
