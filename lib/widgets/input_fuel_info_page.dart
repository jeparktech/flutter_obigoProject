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
  FuelInformation _fuelInfo;

  InputFuelInfo(this._image, this._fuelInfo);

  @override
  _InputFuelInfoState createState() => _InputFuelInfoState();
}

class _InputFuelInfoState extends State<InputFuelInfo> {
  Widget _body = Loading();

  @override
  void initState() {
    super.initState();
    _getFuelInfoList();
  }

  Widget _getFuelInfoList() {
    ReceiptRecognize(widget._image).detectFuelInfo().then((fuelInfo) {
      widget._fuelInfo = fuelInfo;
      if (widget._fuelInfo != null) {
        setState(() {
          _body = _fuelInfoPage();
        });
      }
    });
  }

  Widget _fuelInfoPage() {
    return EditFuelInfo(widget._fuelInfo);
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
