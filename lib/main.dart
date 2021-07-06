import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_obigoproject/widgets/calendar/calendar_loader.dart';
import 'package:flutter_obigoproject/widgets/statistics/statistics.dart';
import './widgets/new_Image.dart';
import './dataBase/fuelDBHelper.dart';
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
  static const Map<int, Color> colorMap = {
    50: Color.fromRGBO(42, 52, 59, 0.1),
    100: Color.fromRGBO(42, 52, 59, 0.2),
    200: Color.fromRGBO(42, 52, 59, 0.3),
    300: Color.fromRGBO(42, 52, 59, 0.4),
    400: Color.fromRGBO(42, 52, 59, 0.5),
    500: Color.fromRGBO(42, 52, 59, 0.6),
    600: Color.fromRGBO(42, 52, 59, 0.7),
    700: Color.fromRGBO(42, 52, 59, 0.8),
    800: Color.fromRGBO(42, 52, 59, 0.9),
    900: Color.fromRGBO(42, 52, 59, 1.0),

  };
  static const MaterialColor _2A363B = MaterialColor(0xFF2A363B, colorMap);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: _2A363B,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
