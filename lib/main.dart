import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import './widgets/calendar.dart';

void main() async {
  // DB 테스트
  // var fuelDBHelper = FuelDBHelper();

  // var fuel1 = FuelInformation(
  //     address: "인천광역시 연수구 인천타워대로 253-25",
  //     date: 20210622,
  //     fuelType: '휘발유',
  //     quantity: 30,
  //     unitPrice: 1600,
  //     totalPrice: 48000);

  // await fuelDBHelper.insertFuelInfo(fuel1);

  // print(await fuelDBHelper.fuelInfos());

  // await fuelDBHelper
  //     .updateFuelInfo(FuelInformation(date: fuel1.date, quantity: 50));
  // print(await fuelDBHelper.fuelInfos());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PickedFile _image;
  final _picker = ImagePicker();

  getGalleryImage() async{
    var image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  getCameraImage() async {
    var image = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }


  openBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.photo),
              title: Text("Photos"),
              onTap: () {
                getGalleryImage();
              }
          ),
          ListTile(
              leading: Icon(Icons.camera),
              title: Text("Camera"),
              onTap: () {
                getCameraImage();
              }
          ),
        ],
      );
    },
    );
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.assessment_outlined),onPressed: () => {}), //통계버튼
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openBottomSheet(context);
        },
        child: Icon(Icons.camera_alt_outlined),
        backgroundColor: Colors.grey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey, //Backgound color of the bar
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex,
        onTap: (int index){
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
  List <Widget> _widgetOptions = [
    Calendar(),
    Text(
      'Category',
      style: TextStyle(fontSize: 30),
    ),
  ];
}
