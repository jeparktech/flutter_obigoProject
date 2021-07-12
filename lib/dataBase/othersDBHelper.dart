import 'dart:async';
import '../models/otherInfo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';

class OthersDBHelper {
  Future<Database>? othersDB;

  OthersDBHelper() {
    othersDB = openOthersInfoDB();
  }

  Future<Database> openOthersInfoDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Open Database: othersDB
    othersDB = openDatabase(
      join(await getDatabasesPath(), 'car_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE othersInfo(date TEXT PRIMARY KEY, totalAmount INTEGER, cm INTEGER, memo TEXT, infoType INTEGER)');
      },
      version: 1,
    );

    return othersDB!;
  }

  //Insert fuelInfo into the database
  Future<void> insertOthersInfo(OtherInformation fuelInfo) async {
    final db = await othersDB;

    await db!.insert(
      'othersInfo',
      fuelInfo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Retrieves all othersInfo from the othersInfo table
  Future<List<OtherInformation>> othersInfo() async {
    final db = await othersDB;

    final List<Map<String, dynamic>> maps = await db!.query('othersInfo');

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

  //Update the OthersInfo in the database
  Future<void> updateOthersInfo(OtherInformation fuelInfo) async {
    final db = await othersDB;

    await db!.update(
      'othersInfo',
      fuelInfo.toMap(),
      where: 'date = ?',
      whereArgs: [fuelInfo.date],
    );
  }

  //Delete the othersInfo in the database
  Future<void> deleteOthersInfo(String date) async {
    final db = await othersDB;

    await db!.delete(
      'othersInfo',
      where: 'date = ?',
      whereArgs: [date],
    );
  }

  Future<bool> hasOthersInfo(String date) async {
    final db = await othersDB;

    var res =
        await db!.rawQuery('SELECT * FROM othersInfo WHERE date = ?', [date]);

    if (res == null) {
      return false;
    }
    return true;
  }

  Future<List<OtherInformation>> getMonthList(int year, int month) async {
    final List<OtherInformation> otherList = await othersInfo();
    DateTime createdDate;
    List<OtherInformation> sameMonthList = [];

    for (int i = 0; i < otherList.length; i++) {
      createdDate = DateTime.parse(otherList[i].date!);
      if (createdDate.year == year && createdDate.month == month) {
        sameMonthList.add(otherList[i]);
      }
    }

    return sameMonthList;
  }
}
