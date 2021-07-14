import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/models/otherInfo.dart';
import 'package:flutter_obigoproject/pages/edit_other_info_page.dart';
import 'package:intl/intl.dart';

import '../models/fuelInfo.dart';
import '../pages/edit_fuel_info_page.dart';
import '../dataBase/fuelDBHelper.dart';
import './edit_fuel_info.dart';

class TransactionList extends StatefulWidget {
  final List<dynamic> txList;
  final tx;
  final Function callBack;

  TransactionList({
    required this.txList,
    required this.tx,
    required this.callBack,
  });

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  List<FuelInformation> getFuelInfoList() {
    List<FuelInformation> fuelInfoList = [];

    for (var info in widget.txList) {
      if (info is FuelInformation) {
        fuelInfoList.add(info);
      }
    }
    return fuelInfoList;
  }

  List<OtherInformation> getOtherInfoList() {
    List<OtherInformation> otherInfoList = [];

    for (var info in widget.txList) {
      if (info is OtherInformation) {
        otherInfoList.add(info);
      }
    }
    return otherInfoList;
  }

  openBottomSheet(BuildContext context, List<dynamic> list, dynamic info) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        List<FuelInformation> fuelList = getFuelInfoList();
        List<OtherInformation> otherList = getOtherInfoList();
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
                    if (info is FuelInformation) {
                      FuelInformation fuelInfo = info;
                      Navigator.of(context)
                          .pushNamed(EditFuelInfoPage.routeName, arguments: {
                        'fuelInfo': fuelInfo,
                        'fuelList': fuelList
                      });
                    } else if (info is OtherInformation) {
                      OtherInformation otherInfo = info;
                      Navigator.of(context)
                          .pushNamed(EditOtherInfoPage.routeName, arguments: {
                        'otherInfo': otherInfo,
                        'otherList': otherList
                      });
                    }
                  }),
              ListTile(
                  title: Center(
                    child: Text("Delete"),
                  ),
                  onTap: () {
                    if (info is FuelInformation) {
                      print('fuelInformation is deleting');
                      FuelInformation fuelInfo = info;
                      fuelList.remove(fuelInfo); //fuelInfo list에서 삭제
                      FuelDBHelper()
                          .deleteFuelInfo(fuelInfo.date); //fuelInfo DB에서 삭제
                      Navigator.pop(context);
                      widget.callBack(widget.txList, fuelList);
                    } else if (info is OtherInformation) {
                      OtherInformation otherInfo = info;
                      print(
                          'otherInformation is deleting, id: ${otherInfo.id}');
                      otherList.remove(otherInfo);
                      FuelDBHelper().deleteOthersInfo(otherInfo.id!);
                      Navigator.pop(context);
                      widget.callBack(widget.txList, otherList);
                    }
                  }),
            ],
          ),
        );
      },
    );
  }

  Widget getInfoType() {
    String str;
    if (widget.tx is FuelInformation) {
      str = '주유';
    } else {
      OtherInformation info = widget.tx as OtherInformation;
      switch (info.infoType) {
        case InfoType.carWashInfo:
          str = '세차';
          break;
        case InfoType.parkingInfo:
          str = '주차';
          break;
        case InfoType.repairInfo:
          str = '수리';
          break;
        default:
          str = '';
      }
    }

    return Text(str,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget getInfoIcon() {
    Icon? _icon;
    Color? _color;

    if (widget.tx is FuelInformation) {
      _icon = Icon(
        Icons.local_gas_station_rounded,
        size: 28,
        color: Colors.white,
      );
      _color = Colors.blue;
    } else {
      OtherInformation info = widget.tx as OtherInformation;
      switch (info.infoType) {
        case InfoType.carWashInfo:
          _icon = Icon(
            Icons.car_rental_outlined,
            size: 28,
            color: Colors.white,
          );
          _color = Colors.blue;
          break;
        case InfoType.parkingInfo:
          _icon = Icon(
            Icons.local_parking_outlined,
            size: 28,
            color: Colors.white,
          );
          _color = Colors.blue;
          break;
        case InfoType.repairInfo:
          _icon = Icon(
            Icons.car_repair_outlined,
            size: 28,
            color: Colors.white,
          );
          _color = Colors.blue;
          break;
        default:
          _icon = Icon(
            Icons.error_outline,
            size: 28,
            color: Colors.white,
          );
          _color = Colors.blue;
      }
    }
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: _color,
            shape: BoxShape.circle,
          ),
        ),
        Center(child: _icon),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Center(
                  child: getInfoIcon(),
                ),
              ),
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getInfoType(),
                    SizedBox(height: 5),
                    Text(
                      DateFormat('MM.dd')
                          .format(DateTime.parse(widget.tx.date)),
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 31,
                    child: Row(
                      children: [
                        widget.tx is FuelInformation
                            ? Text(
                                '${widget.tx.unitPrice} ₩/L',
                                style: TextStyle(color: Colors.black54),
                              )
                            : Container(),
                        SizedBox(
                          width: 16,
                          child: InkWell(
                            child: Icon(
                              Icons.more_vert,
                              size: 18,
                              color: Colors.black54,
                            ),
                            onTap: () {
                              openBottomSheet(
                                context,
                                widget.txList,
                                widget.tx,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '₩ ${widget.tx.totalPrice}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
