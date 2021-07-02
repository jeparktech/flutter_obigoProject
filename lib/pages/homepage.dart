import 'package:flutter/material.dart';

import '../widgets/calendar/calendar_loader.dart';
import '../widgets/statistics/statistics.dart';
import '../widgets/new_Image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//Test for transction_list

  int _selectedIndex = 0;

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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Home Screen',
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.assessment_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Statistics()),
              );
            }), //통계버튼
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openBottomSheet(context);
        },
        child: Icon(
          Icons.camera_alt,
          color: Colors.grey,
        ),
        backgroundColor: Colors.white,
      ),
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
    Text(
      'Category',
      style: TextStyle(fontSize: 30),
    ),
  ];
}
