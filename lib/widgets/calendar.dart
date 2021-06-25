import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class Calendar extends StatefulWidget {

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {


  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: TableCalendar(

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
        //To stlye the calendar
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: Colors.blue,
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
    );
  }
}
