import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/dataBase/fuelDBHelper.dart';
import 'package:flutter_obigoproject/models/fuelInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_obigoproject/widgets/statistics/statistics.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'Utils.dart';
import 'gasData.dart';

class Chart extends StatefulWidget {
  List<FuelInformation> list;

  Chart({required this.list});

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  int? year;
  int? month;
  List<GasData>? _chartData;
  TooltipBehavior? _tooltipBehavior;
  DateTime dateTime = DateTime.now();

  String dateformat = DateFormat('yyyy/MM').format(DateTime.now());

  int amount = 0;

  List<FuelInformation> getMonthlyFuelList(int year, int month) {
    List<FuelInformation> monthlyList = [];
    DateTime createdDate;
    for (int i = 0; i < widget.list.length; i++) {
      createdDate = DateTime.parse(widget.list[i].date);
      if (createdDate.year == year && createdDate.month == month) {
        monthlyList.add(widget.list[i]);
      }
    }

    return monthlyList;
  }

  void initState() {
    _chartData = getChartData(
        getMonthlyFuelList(DateTime.now().year, DateTime.now().month));
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: new Text('Statistics page'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 130.0,
                vertical: 10.0,
              ),
              width: double.infinity,
              color: primaryColor,
              child: FlatButton(
                color: primaryColor,
                child: Text(
                  dateformat,
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.white,
                        width: 2,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  Utils.showSheet(
                    context,
                    child: buildDatePicker(),
                    onClicked: () {
                      // Utils.showSnackBar(context, 'Selected "$value"');

                      setState(() {
                        dateformat = DateFormat('yyyy/MM').format(dateTime);
                        year = dateTime.year;
                        month = dateTime.month;
                        Text(dateformat);
                        _chartData =
                            getChartData(getMonthlyFuelList(year!, month!));
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: SfCircularChart(
                backgroundColor: primaryColor,
                //title: ChartTitle(text: 'Half yearly sales analysis'),
                legend: Legend(
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.wrap,
                    textStyle: TextStyle(color: Colors.white)),
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  DoughnutSeries<GasData, String>(
                      dataSource: _chartData,
                      xValueMapper: (GasData data, _) => data.type,
                      yValueMapper: (GasData data, _) => data.amount,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                      ),
                      enableTooltip: true,
                      animationDuration: 1000),
                ],
              ),
            ),
            Container(
                width: double.infinity,
                height: 50,
                color: primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          'Transactions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Text(
                          "₩$amount",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  List<GasData> getChartData(List<FuelInformation> list) {
    amount = 0;

    for (int i = 0; i < list.length; i++) {
      amount = amount + list[i].totalPrice;
    }
    final List<GasData> chartData = [
      GasData('주유', amount),
    ];
    return chartData;
  }

  Future<List<FuelInformation>> getList(int year, int month) async {
    var fuelDBHelper = FuelDBHelper();
    List<FuelInformation> seclist =
        await fuelDBHelper.getMonthList(year, month);
    return seclist;
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
