import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    Map<String, dynamic>? data;
  Future<bool> exitCar() async {
    var t = database.getAllCars();

    if (plate1.text.isEmpty ||
        plate2.text.isEmpty ||
        plate3.text.isEmpty ||
        plate4.text.isEmpty) {
      Fluttertoast.showToast(msg: 'لطفا فیلد های خالی را پر کنید');
      return false;
    } else {
      data = await database.getCarToExit(
          plate1.text + plate2.text + plate3.text + plate4.text,
          parkingController.parking!.parkingId);
    }
    if (data == null) {
      Fluttertoast.showToast(msg: 'این شماره پلاک ثبت نشده است');
      return false;
    }
    Map<String, dynamic> row = {
      MyDatabase.ExitDate: DateTime.now().toString(),
      MyDatabase.TotalCharge: getTotalCharge(),
      MyDatabase.Exited: 1
    };
    int r = await database.carExit(
        row, data![MyDatabase.CarID], parkingController.parking!.parkingId!);
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

  getTotalCharge() {
    DateTime s = DateTime.parse(data![MyDatabase.EnterDate]!);
    DateTime t = DateTime.parse(DateTime.now().toString());
    int price = parkingController.parking!.enterCharge!;  
    price +=
        (t.difference(s).inHours+1) * parkingController.parking!.chargePerHour!;
    return price;
  }

  void clear() {
    plate1.text = '';
    plate2.text = '';
    plate3.text = '';
    plate4.text = '';
  }
}
