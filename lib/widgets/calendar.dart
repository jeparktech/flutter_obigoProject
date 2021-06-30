import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/fuelInfo.dart';


class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  
  LinkedHashMap<DateTime, List<FuelInformation>> _events = getEvents();
  ValueNotifier<List<FuelInformation>> _selectedEvents;

  CalendarFormat format = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // void test(List<FuelInformation> list) {
  //   for (int i = 0; i < _events.length; i++) {
  //     _selectedDay = DateTime.parse(list[i].date);
  //     if (_selectedEvents[_selectedDay] != null) {
  //       _selectedEvents[_selectedDay].add(list[i]);
  //     } else {
  //       _selectedEvents[_selectedDay] = [list[i]];
  //     }
  //   }
  // }

  void initState() {
    super.initState();
    if (_events == null) {
      print('event is null');
    }

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  List<FuelInformation> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime(1990),
          lastDay: DateTime(2050),
          calendarFormat: format,
          onFormatChanged: (CalendarFormat _format) {
            setState(() {
              format = _format;
            });
          },
          daysOfWeekVisible: true,

          //Day Changed
          onDaySelected: (DateTime selecDay, DateTime focusDay) {
            if (!isSameDay(_selectedDay, selecDay))
              setState(() {
                _selectedDay = selecDay;
                _focusedDay = focusDay;
              });

            _selectedEvents.value = _getEventsForDay(selecDay);

            //_selectedEvents.value = _getEventsfromDay(selecDay);
          },
          selectedDayPredicate: (DateTime day) {
            return isSameDay(_selectedDay, day);
          },

          eventLoader: _getEventsForDay,

          //To stlye the calendar
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              color: Colors.lightBlue,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(
              color: Colors.blue.shade100,
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: true,
            titleCentered: true,
            formatButtonShowsNext: false,
          ),
        ),
        // ..._getEventsForDay(_selectedDay)
        //     .map((FuelInformation event) => ListTile(
        //           title: Text(
        //             event.toString(),
        //           ),
        //         )),
        // RaisedButton(onPressed: () => test(_events), child: Text('test')),
      ]),
    );
  }

}

LinkedHashMap<DateTime, List<FuelInformation>> _eventsGenerated() {
  //var fuelDBHelper = FuelDBHelper();
  //var fuelInfoList = await fuelDBHelper.fuelInfos();

  var fuelInfoList = [
    FuelInformation(
        date: '2021-06-29',
        fuelType: '휘발유',
        quantity: 59.65,
        totalPrice: 89000,
        unitPrice: 1350),
         FuelInformation(
        date: '2021-06-15',
        fuelType: '휘발유',
        quantity: 59.65,
        totalPrice: 89000,
        unitPrice: 1350)
  ];
  print(fuelInfoList);
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

LinkedHashMap<DateTime, List<FuelInformation>> getEvents() {
  // LinkedHashMap<DateTime, List<FuelInformation>> events;
  // _eventsGenerated().then((val) {
  //   events = val;
  // });

  // print('events: $events');

  return _eventsGenerated();
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
