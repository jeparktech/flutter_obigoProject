import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/models/fuelInfo.dart';
import 'package:flutter_obigoproject/widgets/statistics/chart.dart';
import 'package:flutter_obigoproject/widgets/statistics/chart_errorView.dart';
import 'package:flutter_obigoproject/widgets/statistics/selectdate_page.dart';

class Statistics extends StatefulWidget {
  
  List<FuelInformation>? list;

  Statistics(this.list);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  int? year;
  int? month;


  // List<FuelInformation> getSelectedList(int year, int month) {
  //   List<FuelInformation> selectedMonthList =  [];
  //    DateTime createdDate;

  //    for (int i = 0; i < widget.list!.length; i++) {
  //     createdDate = DateTime.parse(widget.list![i].date);
  //     if (createdDate.year == year && createdDate.month == month) {
  //       selectedMonthList.add(widget.list![i]);
  //     }
  //   }
  //   return selectedMonthList;
  // }



  @override
  Widget build(BuildContext context) {
    if (widget.list == null) {
      print('error');
      return ChartErrorView();
    } else {
      print('success');
      return Chart(widget.list);
    }
  }
}
