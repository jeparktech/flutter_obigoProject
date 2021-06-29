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

  final List<FuelInformation> _events = [
    FuelInformation(
      date:  "2021-06-25", 
      fuelType: '경유', 
      unitPrice: 1318, 
      quantity: 22.762,
      totalPrice: 30000
    ),
    FuelInformation(
      date:  "2021-06-10", 
      fuelType: '경유', 
      unitPrice: 1318, 
      quantity: 22.762,
      totalPrice: 30000
    ),
  ];
  void test(List<FuelInformation> list) {
    // for (int i = 0; i < list.length; i++) {
    //   setState(() {
    //   DateTime changedDate = DateTime.parse(list[i].date);
    //   selectedDay = changedDate;
    //   selectedEvents[selectedDay].add(list[0]);
    //   });
      

    // }
    FuelInformation v1 = FuelInformation(
      date:  "2021-06-10", 
      fuelType: '경유', 
      unitPrice: 1318, 
      quantity: 22.762,
      totalPrice: 30000
    );
    setState(() {
      DateTime changedDate = DateTime.parse(v1.date);
      print(changedDate);
      selectedDay = changedDate;
      selectedEvents[selectedDay].add(v1);
    });
  }
  

  

  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<FuelInformation> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
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

        //Day Changed
        onDaySelected: (DateTime selecDay, DateTime focusDay) {
          setState(() {
            selectedDay = selecDay;
            focusedDay = focusDay;
          
          });
        },
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
      ..._getEventsfromDay(selectedDay).map((FuelInformation event) => ListTile(title: Text(event.toString(),),)
      ),
      RaisedButton(onPressed: () => test(_events), child: Text('test')),]
      ),
    );
  }
}
