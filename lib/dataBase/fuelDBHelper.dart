import 'dart:async';
import '../models/fuelInfo.dart';
import '../models/otherInfo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';

class FuelDBHelper {
  Future<Database>? fuelDB;

  FuelDBHelper() {
    fuelDB = openFuelInfoDB();
  }

  Future<Database> openFuelInfoDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    String path = join(await getDatabasesPath(), 'car_database.db');
    // Open Database: fuelDB
    fuelDB = openDatabase(
      path,
      onCreate: (db, version) async {
        db.execute(
            'CREATE TABLE fuelInfos(date TEXT PRIMARY KEY, address TEXT, fuelType TEXT, unitPrice INTEGER, quantity REAL, totalPrice INTEGER)');
        db.execute(
            'CREATE TABLE otherInfos(date TEXT PRIMARY KEY, totalAmount INTEGER, cm INTEGER, memo TEXT, infoType INTEGER)');
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
    list.addAll(await othersInfo() as dynamic);

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

  Future<List<dynamic>> othersInfo() async {
    final db = await fuelDB;

    final List<Map<String, dynamic>> maps = await db!.query('otherInfos');

    return List.generate(maps.length, (i) {
      return OtherInformation(
        date: maps[i]['date'],
        totalAmount: maps[i]['totalAmount'],
        cm: maps[i]['cm'],
        memo: maps[i]['memo'],
        infoType: maps[i]['infoType'],
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

  Future<void> deleteOthersInfo(String date) async {
    final db = await fuelDB;

    await db!.delete(
      'otherInfos',
      where: 'date = ?',
      whereArgs: [date],
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

  Future<List<dynamic>> getMonthList(int year, int month) async {
    final List<dynamic> fuelList = await fuelInfos();
    DateTime createdDate;
    List<dynamic> sameMonthList = [];

    for (int i = 0; i < fuelList.length; i++) {
      createdDate = DateTime.parse(fuelList[i].date);
      if (createdDate.year == year && createdDate.month == month) {
        sameMonthList.add(fuelList[i]);
      }
    }

    return sameMonthList;
  }
}
