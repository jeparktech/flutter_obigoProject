import 'dart:io';

import 'package:flutter/material.dart';

class EditFuelInfo extends StatelessWidget {
  final File _image;
  final _dateController = TextEditingController();
  final _fuelTypeController = TextEditingController();
  final _unitPriceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _totalPriceController = TextEditingController();
  final List _list;
  EditFuelInfo(this._image, this._list);

  void _submitData() {
    final enteredDate = int.parse(_dateController.text);
    final enteredFuelType = _fuelTypeController.text;
    final enteredUnitPrice = int.parse(_unitPriceController.text);
    final enteredQuantitiy = double.parse(_quantityController.text);
    final enteredTotalPrice = int.parse(_totalPriceController.text);
  }

  bool _isInteger(String str) {
    if (str == null) {
      return false;
    }
    return int.tryParse(str) != null;
  }

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
                validator: (value) {
                  return (_isInteger(value)) ? null : '숫자만 입력하세요.';
                },
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
