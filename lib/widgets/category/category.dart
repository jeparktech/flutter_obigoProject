import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter_obigoproject/models/otherInfo.dart';
import 'package:flutter_obigoproject/widgets/edit_other_info.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key}) : super(key: key);

  final tabItems = ['세차', '주차', '정비'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: ButtonsTabBar(
                  //decoration: BoxDecoration(border: Border.all()),
                  backgroundColor: Colors.blue,
                  unselectedBackgroundColor: Colors.grey[300],
                  unselectedLabelStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      text: '세차',
                    ),
                    Tab(
                      text: '주차',
                    ),
                    Tab(text: '정비'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Center(
                      child: EditOtherInfo(
                        infoType: InfoType.carWashInfo,
                      ),
                    ),
                    Center(
                      child: EditOtherInfo(
                        infoType: InfoType.parkingInfo,
                      ),
                    ),
                    Center(
                      child: EditOtherInfo(
                        infoType: InfoType.repairInfo,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
