import 'dart:io';

import 'package:flutter/material.dart';
import '../models/fuelInfo.dart';
import 'package:image_picker/image_picker.dart';

import './input_fuel_info_page.dart';

class NewImage extends StatefulWidget {
  @override
  _NewImageState createState() => _NewImageState();
}

class _NewImageState extends State<NewImage> {
  File _image;
  FuelInformation _fuelInfo;

  void navigateToNextPage(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(
      builder: (_) {
        return InputFuelInfo(_image, _fuelInfo);
      },
    ));
  }

  void getPhoto(ImageSource source, BuildContext ctx) async {
    final _picker = ImagePicker();
    PickedFile f = await _picker.getImage(source: source);

    setState(() {
      if (f != null) {
        _image = File(f.path);

        navigateToNextPage(ctx);
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
                getPhoto(ImageSource.gallery, context);
              }),
          ListTile(
              leading: Icon(Icons.camera),
              title: Text("Camera"),
              onTap: () {
                getPhoto(ImageSource.camera, context);
              }),
        ],
      ),
    );
  }
}
