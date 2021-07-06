import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'Utils.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<GDPData>? _chartData;
  TooltipBehavior? _tooltipBehavior;
  DateTime dateTime = DateTime.now();
  DateTime? value;

  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      color: Colors.transparent,
                      width: 100,
                      height: 30,
                      child: OutlinedButton(
                        onPressed: () {
                          Utils.showSheet(
                            context,
                            child: buildDatePicker(),
                            onClicked: () {
                              final value =
                                  DateFormat('yyyy/MM').format(dateTime);
                              // Utils.showSnackBar(context, 'Selected "$value"');
                              Navigator.pop(context);
                            },
                          );
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                        child: const Text('hello'),
                      ),
                    ),
                  )
                ],
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Column(
              children: [
                SfCircularChart(
                  title: ChartTitle(text: 'chart test'),
                  legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    DoughnutSeries<GDPData, String>(
                        dataSource: _chartData,
                        xValueMapper: (GDPData data, _) => data.continent,
                        yValueMapper: (GDPData data, _) => data.gdp,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        enableTooltip: true)
                  ],
                ),
              ],
            )));
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Oceania', 1600),
      GDPData('Europe', 2000),
      GDPData('Korea', 2200),
      GDPData('Japan', 3000),
      GDPData('China', 1800),
      GDPData('Taiwan', 4000),
    ];
    return chartData;
  }

  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          minimumYear: 2015,
          maximumYear: DateTime.now().year,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
