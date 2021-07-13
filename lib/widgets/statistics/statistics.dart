import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/models/fuelInfo.dart';

import 'package:flutter_obigoproject/pages/chart_error_page.dart';
import 'package:flutter_obigoproject/pages/chartpage.dart';


class Statistics extends StatefulWidget {
  final List<FuelInformation>? _list;

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
      return ChartErrorPage();
    } else {
      print('success');
      return ChartPage(
        list: widget._list!
      );
    }
  }
}
