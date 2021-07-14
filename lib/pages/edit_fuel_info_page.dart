import 'package:flutter/material.dart';
import '../widgets/edit_fuel_info.dart';
<<<<<<< HEAD
=======
import '../models/fuelInfo.dart';
>>>>>>> 1ba9ef1c14b2c1f6335c2a00650db80cdf2b6d24

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
