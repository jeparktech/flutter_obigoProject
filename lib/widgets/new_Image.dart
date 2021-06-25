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

  void getPhoto(ImageSource source) async {
    final _picker = ImagePicker();
    PickedFile f = await _picker.getImage(source: source);
    setState(() {
      _image = File(f.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                                builder: (context) => InputFuelInfo(_image)));
                      },
                      child: Text('다음'),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
