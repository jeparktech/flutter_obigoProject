import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/dataBase/fuelDBHelper.dart';
import 'package:flutter_obigoproject/models/fuelInfo.dart';
import 'package:flutter_obigoproject/widgets/statistics/chart.dart';
import 'package:flutter_obigoproject/widgets/statistics/chart_errorView.dart';
import 'package:intl/intl.dart';

class Statistics extends StatefulWidget {
  final List<dynamic>? _list;

  const Statistics(this._list);
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._list == null) {
      print('loading');
      return ChartErrorView();
    } else {
      print('success');
      return Chart(
        list: widget._list!,
      );
    }
  }
}
