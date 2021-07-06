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
   List<GDPData> _chartData;
   TooltipBehavior _tooltipBehavior;
   DateTime dateTime = DateTime.now();
   String value =  DateFormat('yyyy/MM').format( DateTime.now());

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
          title: new Text('Statistics page'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
            Navigator.pop(context);
          },),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 150),
                OutlinedButton(
                  onPressed: () {
                  Utils.showSheet(context,
                  child: buildDatePicker(),
                  onClicked: () {
                    value = DateFormat('yyyy/MM').format(dateTime);
                    // Utils.showSnackBar(context, 'Selected "$value"');
                    Navigator.pop(context);},
                  );},
                  style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                  ),
                  child:  Text(value),
                ),
                SizedBox(width: 60),
                Container(
                  width: 100,
                  height: 80,
                  child: Column(children: [
                    Text("Expense",style: TextStyle(fontSize: 16, color: Colors.black),textAlign: TextAlign.right,),
                    Text("₩",style: TextStyle(fontSize: 16, color: Colors.black),textAlign: TextAlign.center,),
                  ],),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent)
                  ),
                  
                ),
                
              ],
            ),
            SfCircularChart(
              legend: 
                Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: _tooltipBehavior,
              series:<CircularSeries>[
                DoughnutSeries<GDPData, String>(
                  dataSource: _chartData,
                  xValueMapper: (GDPData data, _) => data.continent,
                  yValueMapper: (GDPData data, _) => data.gdp,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ],
            ),
          ],
        ),
        ),
    );
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
  class GDPData{
    GDPData(this.continent, this.gdp);
    final String continent;
    final int gdp;

  }

