import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/custom/Utils.dart';
import 'package:flutter_obigoproject/models/expense.dart';
import 'package:flutter_obigoproject/models/fuelInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_obigoproject/models/fuel_qtt_data.dart';
import 'package:flutter_obigoproject/models/otherInfo.dart';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatefulWidget {
  List<dynamic>? list;

  ChartPage({required this.list});

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<FuelQttData>? chartBarData;
  List<FuelInformation>? _fuelList;
  List<OtherInformation>? _othList;

  int? year;
  int? month;
  List<Expense>? _chartData;
  TooltipBehavior? _tooltipBehavior;
  DateTime dateTime = DateTime.now();

  String dateformat = DateFormat('yyyy/MM').format(DateTime.now());

  int gasAmount = 0;
  int maintenanceFee = 0;
  int totalAmount = 0;

  List<FuelInformation> getFuelInfoList() {
    List<FuelInformation> fuelInfoList = [];

    for (var info in widget.list!) {
      if (info is FuelInformation) {
        fuelInfoList.add(info);
      }
    }
    return fuelInfoList;
  }
  List<OtherInformation> getOtherInfoList() {
    List<OtherInformation> otherInfoList = [];

    for (var info in widget.list!) {
      if (info is OtherInformation) {
        otherInfoList.add(info);
      }
    }
    return otherInfoList;
  }



  void initState() {
    _fuelList = getFuelInfoList();
    _othList = getOtherInfoList();
    chartBarData = getChartBarData(getMonthlyFuelQtt(DateTime.now().year));
    _chartData = getPieChartData(
        getMonthlyPieList(DateTime.now().year, DateTime.now().month));
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

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
        body: ListView(
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
                      setState(() {
                        dateformat = DateFormat('yyyy/MM').format(dateTime);
                        year = dateTime.year;
                        month = dateTime.month;
                        Text(dateformat);
                        _chartData =
                            getPieChartData(getMonthlyPieList(year!, month!));
                        chartBarData =
                            getChartBarData(getMonthlyFuelQtt(year!));
                      });
                      Navigator.pop(context);
                    },
                  );
                },
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
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Text(
                          "월별지출",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Text(
                          "Total  ₩$totalAmount",
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
                  DoughnutSeries<Expense, String>(
                      dataSource: _chartData,
                      xValueMapper: (Expense data, _) => data.category,
                      yValueMapper: (Expense data, _) => data.amount,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Text(
                          "월별 주유량",
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
            Container(
              height: 300,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: 800,
                    color: primaryColor,
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        //zoomPanBehavior: _zoomPanBehavior,
                        margin: EdgeInsets.all(20),
                        primaryYAxis: NumericAxis(minimum: 10, maximum: 100),
                        series: <CartesianSeries>[
                          ColumnSeries<FuelQttData, String>(
                              dataSource: chartBarData!,
                              xValueMapper: (FuelQttData data, _) => data.month,
                              yValueMapper: (FuelQttData data, _) => data.qtt,
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true, color: Colors.white),
                              emptyPointSettings: EmptyPointSettings(
                                  // Mode of empty point
                                  mode: EmptyPointMode.average))
                        ]),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  List<double> getMonthlyFuelQtt(int year) {
    List<double> monthlyList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    DateTime createdDate;
    for (int i = 0; i < _fuelList!.length; i++) {
      createdDate = DateTime.parse(_fuelList![i].date);
      if (createdDate.year == year) {
        print(createdDate.month);
        monthlyList[createdDate.month] =
            monthlyList[createdDate.month] + _fuelList![i].quantity;
        print(monthlyList[createdDate.month]);
      }
    }
    return monthlyList;
  }

  List<FuelQttData> getChartBarData(List<double> list) {
    final List<FuelQttData> chartBarData = [
      FuelQttData('Jan', list[1]),
      FuelQttData('Feb', list[2]),
      FuelQttData('Mar', list[3]),
      FuelQttData('Apr', list[4]),
      FuelQttData('Man', list[5]),
      FuelQttData('Jun', list[6]),
      FuelQttData('July', list[7]),
      FuelQttData('Aug', list[8]),
      FuelQttData('Sep', list[9]),
      FuelQttData('Oct', list[10]),
      FuelQttData('Nov', list[11]),
      FuelQttData('Dec', list[12]),
    ];

    return chartBarData;
  }

   List<dynamic> getMonthlyPieList(int year, int month) {
    List<dynamic> monthlyList = [];
    
    DateTime createdDate;
    for (int i = 0; i < widget.list!.length; i++) {
      createdDate = DateTime.parse(widget.list![i].date);
      if (createdDate.year == year && createdDate.month == month) {
        monthlyList.add(widget.list![i]);
      }
    }

    return monthlyList;
  }

  List<Expense> getPieChartData(List<dynamic> list) {
    gasAmount = 0;
    maintenanceFee = 0;
    totalAmount = 0;
    for(int i = 0; i < list.length; i++) {
      if(list[i] is OtherInformation) {
        maintenanceFee = maintenanceFee + list[i].totalPrice as int ;
      } else {
        gasAmount = gasAmount + list[i].totalPrice as int;
      }
    }

    final List<Expense> chartData = [
      Expense('주유', gasAmount),
      Expense('기타', maintenanceFee)
    ];
    totalAmount = gasAmount + maintenanceFee;
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
