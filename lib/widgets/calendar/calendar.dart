import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/fuelInfo.dart';
import '../transaction_list.dart';

class Calendar extends StatefulWidget {
  LinkedHashMap<DateTime, List<FuelInformation>> _events;

  Calendar(this._events);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  ValueNotifier<List<FuelInformation>>? _selectedEvents;

  CalendarFormat format = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<FuelInformation> _getEventsForDay(DateTime day) {
    return widget._events[day] ?? [];
  }

  void callBack(List<FuelInformation> initialFuelInfos,
      List<FuelInformation> editiedFuelInfos) {
    setState(() {
      initialFuelInfos = editiedFuelInfos;
    });
  }

  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
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

            _selectedEvents!.value = _getEventsForDay(selecDay);

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
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<FuelInformation>>(
            valueListenable: _selectedEvents!,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return TransactionList(
                    txList: value,
                    tx: value[index],
                    callBack: callBack,
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
