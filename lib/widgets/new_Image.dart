import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewImage extends StatefulWidget {
  @override
  _NewImageState createState() => _NewImageState();
}

class _NewImageState extends State<NewImage> {
  PickedFile _image;
  final _picker = ImagePicker();
  getGalleryImage() async {
    var image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  getCameraImage() async {
    var image = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = image;
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
              getGalleryImage();
            }),
        ListTile(
            leading: Icon(Icons.camera),
            title: Text("Camera"),
            onTap: () {
              getCameraImage();
            }),
      ],
    );
  }
}
