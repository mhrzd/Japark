import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japark/database/database.dart';
import 'package:japark/models/car.dart';
import 'dart:convert';

import 'package:japark/models/parking.dart';

class ParkingController extends GetxController {
  MyDatabase database = MyDatabase.instance;
  Parking? parking;
  List<Car> cars = [];
  int profit = 0;
  int max = 0, min = 0;
  List<Car> lastMonthCars = [];
  TextEditingController parkingNameT = TextEditingController();
  TextEditingController capacityT = TextEditingController();
  TextEditingController enterChargeT = TextEditingController();
  TextEditingController chargePHT = TextEditingController();
  TextEditingController answerT = TextEditingController();
  TextEditingController questionT = TextEditingController();
  void setOccupied(int i) {
    parking!.occupied = i;
    update();
  }

  void setTextFields() {
    parkingNameT.text = parking!.parkingName!;
    capacityT.text = parking!.capacity!.toString();
    enterChargeT.text = parking!.enterCharge!.toString();
    chargePHT.text = parking!.chargePerHour!.toString();
    answerT.text = parking!.answer!;
    questionT.text = parking!.question!;
  }

  Map<String, double> getGraphMap() {
    Map<String, double> data = {
      'occupied': parking!.occupied!.toDouble(),
      'free': (parking!.capacity! - parking!.occupied!).toDouble()
    };
    return data;
  }

  Future<List<Car>> getAllParkingCars() async {
    var r = await database.getParkingCars(parking!.parkingId);
    cars = [];
    r.forEach((element) {
      cars.add(Car.fromJson(element!));
    });
    return cars;
  }

  Future<List<Car>> getLastMonthCars() async {
    var r = await getAllParkingCars();
    lastMonthCars = [];
    r.forEach((car) {
      if (car.exitDate != null) {
        if (car.exitDate!
            .isAfter(DateTime.now().subtract(Duration(days: 30)))) {
          lastMonthCars.add(car);
        }
      }
    });
    return lastMonthCars;
  }

  int getLastMonthCarsCount() {
    return lastMonthCars.length;
  }

  Future<int> getLastMonthProfit() async {
    var r = await getLastMonthCars();
    profit = 0;
    min = r[0].totalCharge!;
    r.forEach((car) {
      if (car.totalCharge != null) {
        profit += car.totalCharge!;
        if (car.totalCharge! > max) max = car.totalCharge!;
        if (car.totalCharge! < min) min = car.totalCharge!;
      }
    });
    update();
    return profit;
  }

  Future<int> editParking() async {
    Parking t = parking!;
    t.parkingName = parkingNameT.text;
    t.capacity = int.parse(capacityT.text);
    t.enterCharge = int.parse(enterChargeT.text);
    t.chargePerHour = int.parse(chargePHT.text);
    t.answer = answerT.text;
    t.question = questionT.text;

    int a = await database.updateParking(t.toJson(), parking!.parkingId);
    var x = await database.getParkingById(parking!.parkingId!);
    parking = Parking.fromJson(x!);
    return a;
  }

  void upDate() async {
    var r = await database.getParkingById(parking!.parkingId!);
    parking = Parking.fromJson(r!);
    update();
  }
}
