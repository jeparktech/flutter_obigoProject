import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import './input_fuel_info_page.dart';
import '../functions/receipt_recognize.dart';

class NewImage extends StatefulWidget {
  @override
  _NewImageState createState() => _NewImageState();
}

class _NewImageState extends State<NewImage> {
  File _image;
  List _list;
  bool loading = true;

  void getFuelInfoList() async {
    _list = await ReceiptRecognize(_image).detectFuelInfo();
  }

  void getPhoto(ImageSource source) async {
    final _picker = ImagePicker();
    PickedFile f = await _picker.getImage(source: source);

    setState(() {
      if (f != null) {
        _image = File(f.path);
        getFuelInfoList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.photo),
              title: Text("Photos"),
              onTap: () {
                getPhoto(ImageSource.gallery);
              }),
          ListTile(
              leading: Icon(Icons.camera),
              title: Text("Camera"),
              onTap: () {
                getPhoto(ImageSource.camera);
              }),
          _image == null
              ? Container(
                  child: Text('Image not selected.'),
                )
              : Container(
                  child: Row(
                    children: [
                      Text('Image is selected'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  InputFuelInfo(_image, _list),
                            ),
                          );
                        },
                        child: Text('다음'),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
