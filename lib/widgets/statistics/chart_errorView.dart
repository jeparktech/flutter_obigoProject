import 'package:flutter/material.dart';

class ChartErrorView extends StatefulWidget {
@override
  _ChartErrorViewState createState() => _ChartErrorViewState();
}

class _ChartErrorViewState extends State<ChartErrorView> {
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