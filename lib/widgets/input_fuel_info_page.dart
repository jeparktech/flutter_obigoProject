//영수증 인식 후 정보 사용자 확인 및 수정 페이지
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/widgets/edit_fuel_info.dart';

class InputFuelInfo extends StatelessWidget {
  final File _image;

  InputFuelInfo(this._image);
  @override
  Widget build(BuildContext context) {
    Widget photo = (_image != null) ? Image.file(_image) : Text('Empty');
    return MaterialApp(
        title: 'title',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Second Page'),
          ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: EditFuelInfo(_image),
              ),
              // Expanded(
              //   child: Center(child: photo),
              // ),
              RaisedButton(
                child: Text('이전'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ));
  }
}
