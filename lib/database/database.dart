import 'dart:io';

import 'package:japark/models/parking.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static final databaseName = "database.db";
  //car table
  static final String CarTable = "car";
  static final String CarID = "carId";
  static final String DriverName = "name";
  static final String CarModel = "model";
  static final String PhoneNumber = "phoneNumber";
  static final String PlateNumber = "plateNumber";
  static final String EnterDate = "enterDate";
  static final String ExitDate = "exitDate";
  static final String EstimatedTime = "estimatedTime";
  static final String ParkFloor = "parkFloor";
  static final String Exited = "exited";
  static final String TotalCharge = "totalCharge";
  //parking table
  static final String ParkingTable = "parking";
  static final String ParkingID = "parkingId";
  static final String Email = "email";
  static final String ParkingName = "parkingName";
  static final String Capacity = "capacity";
  static final String Occupied = "occupied";
  static final String EnterCharge = "enterCharge";
  static final String ChargePerHour = "chargePerHour";
  static final String Floors = "floors";
  static final String Password = "password";
  static final String Question = "question";
  static final String Answer = "answer";

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
    await db.execute("CREATE TABLE " +
        ParkingTable +
        "(" +
        ParkingID +
        " INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE," +
        Email +
        " TEXT NOT NULL UNIQUE," +
        ParkingName +
        " TEXT NOT NULL," +
        Capacity +
        " INTEGER NOT NULL," +
        Occupied +
        " INTEGER NOT NULL DEFAULT 0," +
        EnterCharge +
        " INTEGER NOT NULL," +
        ChargePerHour +
        " INTEGER NOT NULL," +
        Floors +
        " INTEGER NOT NULL," +
        Password +
        " TEXT NOT NULL," +
        Question +
        " TEXT NOT NULL," +
        Answer +
        " TEXT NOT NULL" +
        ");");
    await db.execute("CREATE TABLE " +
        CarTable +
        "(" +
        CarID +
        " INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE," +
        DriverName +
        " TEXT NOT NULL," +
        CarModel +
        " TEXT," +
        PhoneNumber +
        " TEXT," +
        PlateNumber +
        " TEXT NOT NULL," +
        EnterDate +
        " TEXT NOT NULL," +
        EstimatedTime +
        " INTEGER NOT NULL," +
        ExitDate +
        " TEXT," +
        ParkFloor +
        " INTEGER NOT NULL," +
        Exited +
        " INTEGER NOT NULL DEFAULT 0," +
        TotalCharge +
        " INTEGER NOT NULL DEFAULT 0," +
        ParkingID +
        " INTEGER NOT NULL," +
        "FOREIGN KEY (" +
        ParkingID +
        ") REFERENCES parking(" +
        ParkingID +
        "));");
  }

  Future<int> carEnter(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int i = await db!.insert(CarTable, row);
    return i;
  }

  Future<int> carExit(Map<String, dynamic> row, int _carID, int _pID) async {
    Database? db = await instance.database;
    int i = await db!.update(CarTable, row,
        where: '$CarID = ? and $ParkingID = ?', whereArgs: [_carID, _pID]);
    return i;
  }

  Future<int> updateParking(Map<String, dynamic> row, _pId) async {
    Database? db = await instance.database;
    int i = await db!
        .update(ParkingTable, row, where: '$ParkingID = ?', whereArgs: [_pId]);
    return i;
  }

  Future<int> setParkingOccupied(Map<String, dynamic> row,int _pId) async {
    Database? db = await instance.database;
    int i = await db!.update(ParkingTable, row,where: "$ParkingID = ?",whereArgs: [_pId]);
    return i;
  }

  Future<int> addParking(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int i = await db!.insert(ParkingTable, row);
    return i;
  }

  Future<Parking?> getParkingByEmail(_email) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> data = await db!
        .query(ParkingTable + " WHERE $Email = ?", whereArgs: [_email]);
    if (data.isNotEmpty && data != null) {
      return Parking.fromJson(data.first);
    } else
      return null;
  }

  Future<Map<String, dynamic>?> getCarToExit(String _plate, int? _pID) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> data = await db!.query(
        CarTable + " WHERE $PlateNumber = ? and $Exited = ? and $ParkingID = ?",
        whereArgs: [_plate, 0, _pID]);
    if (data.isNotEmpty && data != null) {
      return data.first;
    } else
      return null;
  }

  Future<Map<String, dynamic>?> getParkingById(int _pID) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> data = await db!
        .query(ParkingTable + " WHERE $ParkingID = ?", whereArgs: [_pID]);
    if (data.isNotEmpty && data != null) {
      return data.first;
    } else
      return null;
  }

  Future<Map<String, dynamic>?> login(String _email, String _pass) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> data = await db!.query(
        ParkingTable + " WHERE $Email = ? and $Password = ?",
        whereArgs: [_email, _pass]);
    if (data.isNotEmpty && data != null) {
      return data.first;
    } else
      return null;
  }

  Future<List<Map<String, dynamic>>> getAllParkings() async {
    Database? db = await instance.database;
    return await db!.query(ParkingTable);
  }

  Future<List<Map<String, dynamic>>> getAllCars() async {
    Database? db = await instance.database;
    return await db!.query(CarTable);
  }

  Future<List<Map<String, dynamic>?>> getParkingCars(int? _pId) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> data =
        await db!.query(CarTable + " WHERE $ParkingID = ?", whereArgs: [_pId]);
    if (data.isNotEmpty && data != null) {
      return data;
    } else
      return [];
  }
}
