import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/dataBase/fuelDBHelper.dart';
import 'package:flutter_obigoproject/models/fuelInfo.dart';
import 'package:flutter_obigoproject/widgets/statistics/chart.dart';
import 'package:flutter_obigoproject/widgets/statistics/chart_errorView.dart';
import 'package:intl/intl.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  int? year;
  int? month;
  List<FuelInformation>? _list;
  int? amount;

  void initState() {
    year = DateTime.now().year;
    month = DateTime.now().month;

    getList(year!, month!).then((list) {
      setState(() {
        _list = list;
      });
    });
    super.initState();
  }

  Future<List<FuelInformation>> getList(int year, int month) async {
    var fuelDBHelper = FuelDBHelper();
    _list = await fuelDBHelper.getMonthList(year, month);
    return _list!;
  }

  @override
  Widget build(BuildContext context) {
    if (_list == null) {
      print('loading');
      return ChartErrorView();
    } else {
      print('success');
      return Chart(_list!);
    }
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
