import 'dart:async';
import '../models/fuelInfo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';

class FuelDBHelper {
  Future<Database> fuelDB;

  FuelDBHelper() {
    fuelDB = openFuelInfoDB();
  }

  Future<Database> openFuelInfoDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Open Database: fuelDB
    fuelDB = openDatabase(
      join(await getDatabasesPath(), 'car_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE fuelInfos(date TEXT PRIMARY KEY, address TEXT, fuelType TEXT, unitPrice INTEGER, quantity REAL, totalPrice INTEGER)');
      },
      version: 1,
    );

    return fuelDB;
  }

  //Insert fuelInfo into the database
  Future<void> insertFuelInfo(FuelInformation fuelInfo) async {
    final db = await fuelDB;

    await db.insert(
      'fuelInfos',
      fuelInfo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Retrieves all fuelInfos from the fuelInfos table
  Future<List<FuelInformation>> fuelInfos() async {
    final db = await fuelDB;

    final List<Map<String, dynamic>> maps = await db.query('fuelInfos');

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

  //Update the fuelInfo in the database
  Future<void> updateFuelInfo(FuelInformation fuelInfo) async {
    final db = await fuelDB;

    await db.update(
      'fuelInfos',
      fuelInfo.toMap(),
      where: 'date = ?',
      whereArgs: [fuelInfo.date],
    );
  }

  //Delete the fuelInfo in the database
  Future<void> deleteFuelInfo(String date) async {
    final db = await fuelDB;

    await db.delete(
      'fuelInfos',
      where: 'date = ?',
      whereArgs: [date],
    );
  }

  Future<bool> hasFuelInfo(String date) async {
    final List<FuelInformation> fuelList = await fuelInfos();

    for (FuelInformation fuelInfo in fuelList) {
      if (date == fuelInfo.date) {
        return true;
      }
    }
    return false;
  }
}
