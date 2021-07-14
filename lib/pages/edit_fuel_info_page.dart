import 'package:flutter/material.dart';
import '../widgets/edit_fuel_info.dart';
<<<<<<< HEAD
=======
import '../models/fuelInfo.dart';
>>>>>>> 2980f1bf3b6b8574796132e0d549cc06f888b57d

class EditFuelInfoPage extends StatelessWidget {
  static const routeName = '/edit-fuel-info';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final fuelInfo = routeArgs['fuelInfo'];
    final fuelList = routeArgs['fuelList'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: EditFuelInfo(
        fuelInfo: fuelInfo,
        fuelList: fuelList,
        isEditMode: true,
      ),
    );
  }
}
