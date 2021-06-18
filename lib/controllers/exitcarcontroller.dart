import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/parkingcontroller.dart';
import 'package:japark/database/database.dart';

class ExitCarController extends GetxController {
  MyDatabase database = MyDatabase.instance;
  ParkingController parkingController = Get.find();
  TextEditingController plate1 = TextEditingController();
  TextEditingController plate2 = TextEditingController();
  TextEditingController plate3 = TextEditingController();
  TextEditingController plate4 = TextEditingController();
  TextEditingController phone = TextEditingController();

  Future<bool> exitCar() async {
    var t = database.getAllCars();
    Map<String, dynamic>? data = await database.getCarToExit(
        plate1.text + plate2.text + plate3.text + plate4.text,
        parkingController.parking!.parkingId);
    Map<String, dynamic> row = {
      MyDatabase.ExitDate: DateTime.now().toString(),
      MyDatabase.TotalCharge: getTotalCharge(
          data![MyDatabase.EnterDate]!, DateTime.now().toString()),
      MyDatabase.Exited: 1
    };
    int r = await database.carExit(
        row, data[MyDatabase.CarID], parkingController.parking!.parkingId!);
    if (r != 0 && r != null) {
      parkingController.setOccupied(parkingController.parking!.occupied! - 1);
      await database.setParkingOccupied(
          {MyDatabase.Occupied: parkingController.parking!.occupied},
          parkingController.parking!.parkingId!);
      clear();
      return true;
    } else
      return false;
  }

  getTotalCharge(String since, String till) {
    DateTime s = DateTime.parse(since);
    DateTime t = DateTime.parse(till);
    int price = parkingController.parking!.enterCharge!;
    price +=
        t.difference(s).inHours * parkingController.parking!.chargePerHour!;
    return price;
  }

  void clear() {
    plate1.text = '';
    plate2.text = '';
    plate3.text = '';
    plate4.text = '';
  }
}
