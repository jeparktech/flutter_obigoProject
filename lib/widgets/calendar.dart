import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/models/fuelInfo.dart';
import 'package:table_calendar/table_calendar.dart';


class Calendar extends StatefulWidget {

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {


  Map<DateTime,List<FuelInformation>> selectedEvents;

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  
  void initState() {
    super.initState();
    selectedEvents = {};
  }


  List<FuelInformation> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  //Day Changed
  void  _onDaySelected(DateTime selecDay, DateTime focusDay) {
    setState(() {
        selectedDay = selecDay;
        focusedDay = focusDay;
        selectedEvents[selectedDay] = _getEventsfromDay(selectedDay);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column (
        children: [
          TableCalendar(
            focusedDay: focusedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            daysOfWeekVisible: true,
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
            eventLoader: _getEventsfromDay,
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
      ..._getEventsfromDay(selectedDay).map((FuelInformation event) => ListTile(title: Text('hi'),),),
     RaisedButton(
       onPressed: () => print('success'),
         child: Text('test')),
        ],
      ),
    );
  }

}
