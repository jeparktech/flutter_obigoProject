//영수증 인식 후 정보 사용자 확인 및 수정 페이지
import 'dart:io';

import 'package:flutter_obigoproject/models/fuelInfo.dart';

import '../widgets/loading.dart';
import '../functions/receipt_recognize.dart';
import '../widgets/edit_fuel_info.dart';

import 'package:flutter/material.dart';

class InputFuelInfoPage extends StatefulWidget {
  static const routeName = '/input-fuel-info';
  File? _image;
  FuelInformation? _fuelInfo;

  @override
  _InputFuelInfoState createState() => _InputFuelInfoState();
}

class _InputFuelInfoState extends State<InputFuelInfoPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      widget._image = routeArgs['image'];
      widget._fuelInfo = routeArgs['fuelInfo'];
      ReceiptRecognize(widget._image!).detectFuelInfo().then((fuelInfo) {
        setState(() {
          widget._fuelInfo = fuelInfo;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //Widget photo = (_image != null) ? Image.file(_image) : Text('Empty');
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: widget._fuelInfo == null
          ? Loading()
          : EditFuelInfo(fuelInfo: widget._fuelInfo!),
    );
  }
}
