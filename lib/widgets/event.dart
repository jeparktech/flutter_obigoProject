import 'package:flutter/material.dart';

class Event {
  final String date;
  //List<fuelInfo> transactions;

  //Event({this.transactions})

  Event({
    @required this.date,
  });

  String toString() => this.date;
}
