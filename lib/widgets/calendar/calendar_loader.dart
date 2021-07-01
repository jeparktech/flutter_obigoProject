import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../dataBase/fuelDBHelper.dart';
import '../../models/fuelInfo.dart';
import './calendar.dart';
import './calendar_empty.dart';

class CalendarLoader extends StatefulWidget {
  @override
  _CalenderLoaderState createState() => _CalenderLoaderState();
}

class _CalenderLoaderState extends State<CalendarLoader> {
  LinkedHashMap<DateTime, List<FuelInformation>> _events;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _eventsGenerated().then((events) {
      setState(() {
        _events = events;
      });
    });
  }

  Future<LinkedHashMap<DateTime, List<FuelInformation>>>
      _eventsGenerated() async {
    var fuelDBHelper = FuelDBHelper();
    var fuelInfoList = await fuelDBHelper.fuelInfos();

    // var fuelInfoList = [
    //   FuelInformation(
    //       date: '2021-06-29',
    //       fuelType: '휘발유',
    //       quantity: 59.65,
    //       totalPrice: 53000,
    //       unitPrice: 1350),
    //   FuelInformation(
    //       date: '2021-06-15',
    //       fuelType: '휘발유',
    //       quantity: 59.65,
    //       totalPrice: 89000,
    //       unitPrice: 1350),
    //   FuelInformation(
    //       date: '2021-06-29',
    //       fuelType: '경유',
    //       quantity: 59.65,
    //       totalPrice: 36000,
    //       unitPrice: 1350),
    //   FuelInformation(
    //       date: '2021-06-07',
    //       fuelType: '경유',
    //       quantity: 59.65,
    //       totalPrice: 36000,
    //       unitPrice: 1350)
    // ];
    final Map<DateTime, List<FuelInformation>> _kEventSource = Map.fromIterable(
        fuelInfoList,
        key: (item) => DateTime.parse(item.date),
        value: (item) =>
            getFuelInfoFromDay(DateTime.parse(item.date), fuelInfoList));

    final kEvents = LinkedHashMap<DateTime, List<FuelInformation>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_kEventSource);

    return kEvents;
  }

  List<FuelInformation> getFuelInfoFromDay(
      DateTime day, List<FuelInformation> list) {
    final listFromDay = list.where((val) {
      return DateTime.parse(val.date) == day;
    }).toList();
    return listFromDay;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  Widget build(BuildContext context) {
    if (_events == null) {
      return EmptyCalendar();
    } else {
      return Calendar(_events);
    }
  }
}
