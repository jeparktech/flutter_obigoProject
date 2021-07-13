import 'package:flutter/material.dart';

class ChartErrorPage extends StatefulWidget {
@override
  _ChartErrorPageState createState() => _ChartErrorPageState();
}

class _ChartErrorPageState extends State<ChartErrorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          title: new Text('Statistics page'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
            Navigator.pop(context);
          },),
        ),),);
  }
}