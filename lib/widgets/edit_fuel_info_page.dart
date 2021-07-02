import 'package:flutter/material.dart';
import '../widgets/edit_fuel_info.dart';
import '../models/fuelInfo.dart';

class EditFuelInfoPage extends StatelessWidget {
  final FuelInformation fuelInfo;

  EditFuelInfoPage(this.fuelInfo);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'title',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Second Page'),
          ),
          body: EditFuelInfo(fuelInfo),
        ));
  }
}
