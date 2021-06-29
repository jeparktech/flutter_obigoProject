import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/models/fuelInfo.dart';
import 'package:flutter_obigoproject/widgets/tansaction_list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:table_calendar/table_calendar.dart';


class Calendar extends StatefulWidget {

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  final List<FuelInformation> _userTransactions = [
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
  

  Map<DateTime,List<FuelInformation>> selectedTx; //selected transactions


  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  

  void initState() {
    selectedTx = {};
    super.initState();
  }


  void addNewTx(List<FuelInformation> tx) {
    for (int i = 0; i < tx.length; i++) {
      if (tx[i].date != null) {
        
      }
    }
   }



  List<FuelInformation> _getTxfromDay(String str) {
    DateTime date = DateTime.parse(str);
    return selectedTx[date] ?? [];
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
      
      ],
      ),
    );
  }
}
