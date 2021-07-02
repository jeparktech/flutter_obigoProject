import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/fuelInfo.dart';
import '../pages/edit_fuel_info_page.dart';
import '../dataBase/fuelDBHelper.dart';

class TransactionList extends StatefulWidget {
  final List<dynamic> txList;
  final tx;

  TransactionList({this.txList, this.tx});

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
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
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.local_gas_station_rounded,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('주유',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
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
                    child: Container(
                      //decoration: BoxDecoration(border: Border.all()),
                      child: Row(
                        children: [
                          Text(
                            '${widget.tx.unitPrice} ₩/L',
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(
                            width: 16,
                            child: Container(
                              //decoration: BoxDecoration(border: Border.all()),
                              child: InkWell(
                                child: Icon(
                                  Icons.more_vert,
                                  size: 18,
                                  color: Colors.black54,
                                ),
                                onTap: () {
                                  openBottomSheet(
                                      context, widget.txList, widget.tx);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //decoration: BoxDecoration(border: Border.all()),
                    child: Text(
                      '₩ ${widget.tx.totalPrice}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
          //Text('${widget.tx.totalPrice} 원'),
        ),
      ),
    );
  }
}
