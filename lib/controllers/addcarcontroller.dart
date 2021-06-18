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
      MyDatabase.Exited: 0
    };
    int r = await database.carEnter(row);
    if (r != null) {
      parkingController.setOccupied(parkingController.parking!.occupied! + 1);
      await database.setParkingOccupied(
          {MyDatabase.Occupied: parkingController.parking!.occupied},
          parkingController.parking!.parkingId!);
      clear();
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
}
