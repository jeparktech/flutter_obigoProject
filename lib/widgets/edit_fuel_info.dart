import 'dart:io';

import 'package:flutter/material.dart';

class EditFuelInfo extends StatelessWidget {
  final File _image;
  final dateController = TextEditingController();
  final fuelTypeController = TextEditingController();
  final unitPriceController = TextEditingController();
  final quantityController = TextEditingController();
  final totalPriceController = TextEditingController();
  final List _list;
  EditFuelInfo(this._image, this._list);

  @override
  Widget build(BuildContext context) {
    return _list == null
        ? Text('list is null')
        : Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: '단가',
                    icon: Icon(Icons.stacked_bar_chart_outlined)),
                initialValue: '${_list[0]['unitPrice']}',
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: '수량',
                    icon: Icon(Icons.local_grocery_store_sharp)),
                initialValue: '${_list[1]['quantity']}',
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: '유종', icon: Icon(Icons.local_gas_station)),
                initialValue: _list[3]['fuelType'],
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: '총액', icon: Icon(Icons.attach_money_outlined)),
                initialValue: '${_list[2]['totalPrice']}',
              ),
            ],
          );
  }
}
