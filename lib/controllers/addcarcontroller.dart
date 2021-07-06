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
    Map<String, dynamic> row = {
      MyDatabase.PlateNumber:
          plate1.text + plate2.text + plate3.text + plate4.text,
      MyDatabase.DriverName: name.text,
      MyDatabase.PhoneNumber: phone.text,
      MyDatabase.CarModel: carType.text,
      MyDatabase.EstimatedTime: duration.text,
      MyDatabase.ParkingID: parkingController.parking!.parkingId,
      MyDatabase.EnterDate: DateTime.now().toString(),
      MyDatabase.ParkFloor: setFloor() != null ? int.parse(setFloor()!) : null,
      MyDatabase.Exited: 0
    };
    int r = await database.carEnter(row);
    if (r != null) {
      parkingController.setOccupied(parkingController.parking!.occupied! + 1);
      await database.setParkingOccupied(
          {MyDatabase.Occupied: parkingController.parking!.occupied},
          parkingController.parking!.parkingId!);
      return true;
    } else
      return false;
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
