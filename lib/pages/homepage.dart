import 'package:flutter/material.dart';
import '../models/fuelInfo.dart';
import '../widgets/category/category.dart';

import '../dataBase/fuelDBHelper.dart';
import '../widgets/calendar/calendar_loader.dart';
import '../widgets/statistics/statistics.dart';
import '../widgets/new_Image.dart';
import '../models/otherInfo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//Test for transction_list
  List<FuelInformation>? _list;
  int _selectedIndex = 0;
  List<dynamic>? infoLists;

  //camera button
  openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return NewImage();
      },
    );
  }

  @override
  void initState() {
    getList().then((list) {
      infoLists = list;
    });
    // TODO: implement initState
    super.initState();
  }
  

  Future<List<dynamic>> getList() async {
    return await FuelDBHelper().everyInfos();
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        title: Text(
          'Home Screen',
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.assessment_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Statistics(infoLists)),
              );
            }), //통계버튼
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              onPressed: () {
                openBottomSheet(context);
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey,
              ),
              backgroundColor: Colors.white,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white, //Backgound color of the bar
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Category'),
            icon: Icon(Icons.category_outlined),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  List<Widget> _widgetOptions = [
    CalendarLoader(),
    CategoryPage(),
  ];
}
