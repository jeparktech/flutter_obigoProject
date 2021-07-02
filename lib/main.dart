import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../pages/edit_fuel_info_page.dart';
import '../pages/input_fuel_info_page.dart';
import '../pages/homepage.dart';

void main() async {
  //var fuelDBHelper = FuelDBHelper();

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
      title: 'Flutter Calendar',
      theme: new ThemeData(
        primaryColor: Colors.white,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.black, displayColor: Colors.black),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => HomePage(),
        InputFuelInfoPage.routeName: (ctx) => InputFuelInfoPage(),
        EditFuelInfoPage.routeName: (ctx) => EditFuelInfoPage(),
      },
    );
  }
}
