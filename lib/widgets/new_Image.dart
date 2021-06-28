import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import './input_fuel_info_page.dart';

class NewImage extends StatefulWidget {
  @override
  _NewImageState createState() => _NewImageState();
}

class _NewImageState extends State<NewImage> {
  File _image;
  List _list;

  void getPhoto(ImageSource source) async {
    final _picker = ImagePicker();
    PickedFile f = await _picker.getImage(source: source);

    setState(() {
      if (f != null) {
        _image = File(f.path);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InputFuelInfo(_image, _list),
          ),
        );
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
        ],
      ),
    );
  }
}
