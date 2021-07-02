import 'package:flutter/material.dart';
import '../widgets/edit_fuel_info.dart';
import '../models/fuelInfo.dart';

class EditFuelInfoPage extends StatelessWidget {
  static const routeName = '/edit-fuel-info';

  @override
  Widget build(BuildContext context) {
    final fuelInfo =
        ModalRoute.of(context).settings.arguments as FuelInformation;

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: EditFuelInfo(fuelInfo),
    );
  }
}
