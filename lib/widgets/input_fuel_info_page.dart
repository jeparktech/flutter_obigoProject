//영수증 인식 후 정보 사용자 확인 및 수정 페이지
import 'dart:io';

import './loading.dart';
import '../functions/receipt_recognize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/widgets/edit_fuel_info.dart';

class InputFuelInfo extends StatefulWidget {
  final File _image;
  List _list;

  InputFuelInfo(this._image, this._list);

  @override
  _InputFuelInfoState createState() => _InputFuelInfoState();
}

class _InputFuelInfoState extends State<InputFuelInfo> {
  Widget _body = Loading();

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
    return Column(
      children: [
        Container(
          child: EditFuelInfo(widget._image, widget._list),
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
