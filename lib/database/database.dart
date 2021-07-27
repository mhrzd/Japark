import 'dart:io';

import 'package:japark/models/parking.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static const databaseName = 'database.db';
  //car table
  static const String carTable = 'car';
  static const String carID = 'carId';
  static const String driverName = 'name';
  static const String carModel = 'model';
  static const String phoneNumber = 'phoneNumber';
  static const String plateNumber = 'plateNumber';
  static const String enterDate = 'enterDate';
  static const String exitDate = 'exitDate';
  static const String estimatedTime = 'estimatedTime';
  static const String parkFloor = 'parkFloor';
  static const String exited = 'exited';
  static const String totalCharge = 'totalCharge';
  //parking table
  static const String parkingTable = 'parking';
  static const String parkingID = 'parkingId';
  static const String email = 'email';
  static const String parkingName = 'parkingName';
  static const String capacity = 'capacity';
  static const String occupied = 'occupied';
  static const String enterCharge = 'enterCharge';
  static const String chargePerHour = 'chargePerHour';
  static const String floors = 'floors';
  static const String password = 'password';
  static const String question = 'question';
  static const String answer = 'answer';

  MyDatabase._privateConstructor();

  static final MyDatabase instance = MyDatabase._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDatabase();
      return _database;
    }
  }

  Future<Database> initDatabase() async {
    Directory? directory = await getApplicationDocumentsDirectory();

    String path = directory.path + databaseName;
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE ' +
        parkingTable +
        '(' +
        parkingID +
        ' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,' +
        email +
        ' TEXT NOT NULL UNIQUE,' +
        parkingName +
        ' TEXT NOT NULL,' +
        capacity +
        ' INTEGER NOT NULL,' +
        occupied +
        ' INTEGER NOT NULL DEFAULT 0,' +
        enterCharge +
        ' INTEGER NOT NULL,' +
        chargePerHour +
        ' INTEGER NOT NULL,' +
        floors +
        ' INTEGER NOT NULL,' +
        password +
        ' TEXT NOT NULL,' +
        question +
        ' TEXT NOT NULL,' +
        answer +
        ' TEXT NOT NULL' +
        ');');
    await db.execute('CREATE TABLE ' +
        carTable +
        '(' +
        carID +
        ' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,' +
        driverName +
        ' TEXT NOT NULL,' +
        carModel +
        ' TEXT,' +
        phoneNumber +
        ' TEXT,' +
        plateNumber +
        ' TEXT NOT NULL,' +
        enterDate +
        ' TEXT NOT NULL,' +
        estimatedTime +
        ' INTEGER NOT NULL,' +
        exitDate +
        ' TEXT,' +
        parkFloor +
        ' INTEGER NOT NULL,' +
        exited +
        ' INTEGER NOT NULL DEFAULT 0,' +
        totalCharge +
        ' INTEGER NOT NULL DEFAULT 0,' +
        parkingID +
        ' INTEGER NOT NULL,' +
        'FOREIGN KEY (' +
        parkingID +
        ') REFERENCES parking(' +
        parkingID +
        '));');
  }

  Future<int> carEnter(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int i = await db!.insert(carTable, row);
    return i;
  }

  Future<int> carExit(Map<String, dynamic> row, int _carID, int _pID) async {
    Database? db = await instance.database;
    int i = await db!.update(carTable, row,
        where: '$carID = ? and $parkingID = ?', whereArgs: [_carID, _pID]);
    return i;
  }

  Future<int> updateParking(Map<String, dynamic> row, _pId) async {
    Database? db = await instance.database;
    int i = await db!
        .update(parkingTable, row, where: '$parkingID = ?', whereArgs: [_pId]);
    return i;
  }

  Future<int> setParkingOccupied(Map<String, dynamic> row,int _pId) async {
    Database? db = await instance.database;
    int i = await db!.update(parkingTable, row,where: '$parkingID = ?',whereArgs: [_pId]);
    return i;
  }

  Future<int> addParking(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int i = await db!.insert(parkingTable, row);
    return i;
  }

  Future<Parking?> getParkingByEmail(_email) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> data = await db!
        .query(parkingTable + ' WHERE $email = ?', whereArgs: [_email]);
    if (data.isNotEmpty) {
      return Parking.fromJson(data.first);
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getCarToExit(String _plate, int? _pID) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> data = await db!.query(
        carTable + ' WHERE $plateNumber = ? and $exited = ? and $parkingID = ?',
        whereArgs: [_plate, 0, _pID]);
    if (data.isNotEmpty) {
      return data.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getParkingById(int _pID) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> data = await db!
        .query(parkingTable + ' WHERE $parkingID = ?', whereArgs: [_pID]);
    if (data.isNotEmpty) {
      return data.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> login(String _email, String _pass) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> data = await db!.query(
        parkingTable + ' WHERE $email = ? and $password = ?',
        whereArgs: [_email, _pass]);
    if (data.isNotEmpty) {
      return data.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllParkings() async {
    Database? db = await instance.database;
    return await db!.query(parkingTable);
  }

  Future<List<Map<String, dynamic>>> getAllCars() async {
    Database? db = await instance.database;
    return await db!.query(carTable);
  }

  Future<List<Map<String, dynamic>?>> getParkingCars(int? _pId) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> data =
        await db!.query(carTable + ' WHERE $parkingID = ?', whereArgs: [_pId]);
    if (data.isNotEmpty) {
      return data;
    } else {
      return [];
    }
  }
}
