import 'dart:collection';

import 'package:flutter/material.dart';
import '../../pages/edit_fuel_info_page.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/fuelInfo.dart';
import '../../dataBase/fuelDBHelper.dart';

class Calendar extends StatefulWidget {
  LinkedHashMap<DateTime, List<FuelInformation>> _events;

  Calendar(this._events);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  ValueNotifier<List<FuelInformation>> _selectedEvents;

  CalendarFormat format = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  List<FuelInformation> _getEventsForDay(DateTime day) {
    return widget._events[day] ?? [];
  }

  openBottomSheet(BuildContext context, List<FuelInformation> fuelList,
      FuelInformation fuelInfo) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  title: Center(
                    child: Text("Edit"),
                  ),
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (_) {
                    //     return InputFuelInfo(list);
                    //   },
                    // ));
                    
                    Navigator.of(context).pushNamed(EditFuelInfoPage.routeName,
                        arguments: fuelInfo);
                  }),
              ListTile(
                  title: Center(
                    child: Text("Delete"),
                  ),
                  onTap: () {
                    setState(() {
                      fuelList.remove(fuelInfo); //fuelInfo list에서 삭제
                      FuelDBHelper()
                          .deleteFuelInfo(fuelInfo.date); //fuelInfo DB에서 삭제
                    });
                    Navigator.pop(context);
                  }),
            ],
          ),
        );
      },
    );
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
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<FuelInformation>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.local_gas_station_rounded),
                      onTap: () {
                        print('${value[index]}');
                      },
                      title: Text('${value[index].totalPrice} 원'),
                      subtitle: Text('${value[index].date}'),
                      trailing: IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          openBottomSheet(context, value, value[index]);
                        },
                      ),
                    ),
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
