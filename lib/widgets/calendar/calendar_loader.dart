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
  LinkedHashMap<DateTime, List<dynamic>>? _events;

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

  Future<LinkedHashMap<DateTime, List<dynamic>>> _eventsGenerated() async {
    var fuelDBHelper = FuelDBHelper();
    var infoList = await fuelDBHelper.everyInfos();

    final Map<DateTime, List<dynamic>> _kEventSource = Map.fromIterable(
        infoList,
        key: (item) => DateTime.parse(item.date),
        value: (item) =>
            getFuelInfoFromDay(DateTime.parse(item.date), infoList));

    final kEvents = LinkedHashMap<DateTime, List<dynamic>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_kEventSource);

    return kEvents;
  }

  List<dynamic> getFuelInfoFromDay(DateTime day, List<dynamic> list) {
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
      return Calendar(_events!);
    }
  }
}
