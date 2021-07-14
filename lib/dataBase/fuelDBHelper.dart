import 'dart:async';
import '../models/fuelInfo.dart';
import '../models/otherInfo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';

class FuelDBHelper {
  Future<Database>? fuelDB;
  String? infoType;

  FuelDBHelper() {
    fuelDB = openFuelInfoDB();
  }

  Future<Database> openFuelInfoDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    String path = join(await getDatabasesPath(), 'car_database.db');
    //await deleteDatabase(path);
    // Open Database: fuelDB
    fuelDB = openDatabase(
      path,
      onCreate: (db, version) async {
        db.execute(
            'CREATE TABLE fuelInfos(date TEXT PRIMARY KEY, fuelType TEXT, unitPrice INTEGER, quantity REAL, totalPrice INTEGER)');
        db.execute(
            'CREATE TABLE otherInfos(id INTEGER PRIMARY KEY, date TEXT, totalPrice INTEGER, cm INTEGER, memo TEXT, infoType TEXT)');
      },
      version: 1,
    );

    return fuelDB!;
  }

  //Insert fuelInfo into the database
  Future<void> insertFuelInfo(FuelInformation fuelInfo) async {
    final db = await fuelDB;

    await db!.insert(
      'fuelInfos',
      fuelInfo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertOthersInfo(OtherInformation otherInfo) async {
    final db = await fuelDB;

    await db!.insert(
      'otherInfos',
      otherInfo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<dynamic>> everyInfos() async {
    List<dynamic> list = await fuelInfos() as dynamic;
    list.addAll(await otherInfos() as dynamic);

    return list;
  }

  //Retrieves all fuelInfos from the fuelInfos table
  Future<List<dynamic>> fuelInfos() async {
    final db = await fuelDB;

    final List<Map<String, dynamic>> maps = await db!.query('fuelInfos');

    return List.generate(maps.length, (i) {
      return FuelInformation(
        date: maps[i]['date'],
        fuelType: maps[i]['fuelType'],
        unitPrice: maps[i]['unitPrice'],
        quantity: maps[i]['quantity'],
        totalPrice: maps[i]['totalPrice'],
      );
    });
  }

  Future<List<dynamic>> otherInfos() async {
    final db = await fuelDB;

    final List<Map<String, dynamic>> maps = await db!.query('otherInfos');

    return List.generate(maps.length, (i) {
      infoType = maps[i]['infoType'];
      return OtherInformation(
        date: maps[i]['date'],
        totalPrice: maps[i]['totalPrice'],
        cm: maps[i]['cm'],
        memo: maps[i]['memo'],
        infoType: infoTypeToEnum,
      );
    });
  }

  //Update the fuelInfo in the database
  Future<void> updateFuelInfo(FuelInformation fuelInfo) async {
    final db = await fuelDB;

    await db!.update(
      'fuelInfos',
      fuelInfo.toMap(),
      where: 'date = ?',
      whereArgs: [fuelInfo.date],
    );
  }

  Future<void> updateOthersInfo(OtherInformation fuelInfo) async {
    final db = await fuelDB;

    await db!.update(
      'otherInfos',
      fuelInfo.toMap(),
      where: 'date = ?',
      whereArgs: [fuelInfo.date],
    );
  }

  //Delete the fuelInfo in the database
  Future<void> deleteFuelInfo(String date) async {
    final db = await fuelDB;

    await db!.delete(
      'fuelInfos',
      where: 'date = ?',
      whereArgs: [date],
    );
  }

  Future<void> deleteOthersInfo(int id) async {
    final db = await fuelDB;

    await db!.delete(
      'otherInfos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> hasFuelInfo(String date) async {
    final db = await fuelDB;

    var res =
        await db!.rawQuery('SELECT * FROM fuelInfos WHERE date = ?', [date]);

    if (res == null) {
      return false;
    }
    return true;
  }

  Future<bool> hasOthersInfo(String date) async {
    final db = await fuelDB;

    var res =
        await db!.rawQuery('SELECT * FROM otherInfos WHERE date = ?', [date]);

    if (res == null) {
      return false;
    }
    return true;
  }

  InfoType get infoTypeToEnum {
    switch (infoType) {
      case 'parkingInfo':
        return InfoType.parkingInfo;
      case 'carWashInfo':
        return InfoType.carWashInfo;
      case 'repairInfo':
        return InfoType.repairInfo;
      default:
        return InfoType.carWashInfo;
    }
  }
}
