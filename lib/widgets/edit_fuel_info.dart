import 'dart:io';

import 'package:flutter/material.dart';
import '../functions/receipt_recognize.dart';

class EditFuelInfo extends StatelessWidget {
  final File _image;
  final dateController = TextEditingController();
  final fuelTypeController = TextEditingController();
  final unitPriceController = TextEditingController();
  final quantityController = TextEditingController();
  final totalPriceController = TextEditingController();

  EditFuelInfo(this._image);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(),
      ],
    );
  }
}
