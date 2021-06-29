//영수증 인식 후 정보 사용자 확인 및 수정 페이지
import 'dart:io';

import 'package:flutter_obigoproject/models/fuelInfo.dart';

import './loading.dart';
import '../functions/receipt_recognize.dart';
import './edit_fuel_info.dart';
import '../dataBase/fuelDBHelper.dart';

import 'package:flutter/material.dart';

class InputFuelInfo extends StatefulWidget {
  final File _image;
  List _list;

  InputFuelInfo(this._image, this._list);

  @override
  _InputFuelInfoState createState() => _InputFuelInfoState();
}

class _InputFuelInfoState extends State<InputFuelInfo> {
  Widget _body = Loading();

  void _addFuelInfo(
      {String date,
      int unitPrice,
      double quantity,
      int totalPrice,
      String fuelType}) async {
    final newFuelInfo = FuelInformation(
        date: date,
        fuelType: fuelType,
        quantity: quantity,
        totalPrice: totalPrice,
        unitPrice: unitPrice);

    var fuelDBHelper = FuelDBHelper();
    await fuelDBHelper.insertFuelInfo(newFuelInfo);

    // DB에 정보가 잘 들어갔는지 확인
    List<FuelInformation> fuelInfoList = await fuelDBHelper.fuelInfos();
    for (int i = 0; i < fuelInfoList.length; i++) {
      print('Fuel Information #${i + 1}-----------------${fuelInfoList[i]}\n');
    }
  }

  @override
  void initState() {
    _getFuelInfoList();
  }

  Widget _getFuelInfoList() {
    ReceiptRecognize(widget._image).detectFuelInfo().then((list) {
      widget._list = list;
      if (widget._list != null) {
        setState(() {
          _body = _fuelInfoPage();
        });
      }
    });
  }

  Widget _fuelInfoPage() {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(15),
      children: [
        Container(
          child: EditFuelInfo(_addFuelInfo, widget._list),
        ),
        // Expanded(
        //   child: Center(child: photo),
        // ),
        RaisedButton(
          child: Text('이전'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //Widget photo = (_image != null) ? Image.file(_image) : Text('Empty');
    return MaterialApp(
        title: 'title',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Second Page'),
          ),
          body: _body,
        ));
  }
}
