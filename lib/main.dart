import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_obigoproject/models/fuelInfo.dart';
import './dataBase/fuelDBHelper.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

void main() async {
  var fuelDBHelper = FuelDBHelper();

  var fuel1 = FuelInformation(
      address: "인천광역시 연수구 인천타워대로 253-25",
      date: 20210622,
      fuelType: '휘발유',
      quantity: 30,
      unitPrice: 1600,
      totalPrice: 48000);

  await fuelDBHelper.insertFuelInfo(fuel1);

  print(await fuelDBHelper.fuelInfos());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
