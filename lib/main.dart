import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './widgets/receipt_recog .dart';

void main() async {
  // DB 테스트
  // var fuelDBHelper = FuelDBHelper();

  // var fuel1 = FuelInformation(
  //     address: "인천광역시 연수구 인천타워대로 253-25",
  //     date: 20210622,
  //     fuelType: '휘발유',
  //     quantity: 30,
  //     unitPrice: 1600,
  //     totalPrice: 48000);

  // await fuelDBHelper.insertFuelInfo(fuel1);

  // print(await fuelDBHelper.fuelInfos());

  // await fuelDBHelper
  //     .updateFuelInfo(FuelInformation(date: fuel1.date, quantity: 50));
  // print(await fuelDBHelper.fuelInfos());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'camera',
      home: Scaffold(
        appBar: AppBar(
          title: Text('차계부 demo-1'),
        ),
        body: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
