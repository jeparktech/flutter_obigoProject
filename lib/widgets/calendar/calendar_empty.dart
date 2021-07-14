import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EmptyCalendar extends StatelessWidget {
  final CalendarFormat format = CalendarFormat.month;

  final DateTime _selectedDay = DateTime.now();
  final DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime(1990),
          lastDay: DateTime(2050),
          calendarFormat: format,
          daysOfWeekVisible: true,
          selectedDayPredicate: (DateTime day) {
            return isSameDay(_selectedDay, day);
          },

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
      ]),
    );
  }
}
