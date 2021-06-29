import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/widgets/input_fuel_info_page.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/fuelInfo.dart';
import '../dataBase/fuelDBHelper.dart';
import 'package:image_picker/image_picker.dart';

// 날짜 인식
String _detectDate(String str) {
  String yyMMdd = "";

  var regex = new RegExp(
      '((20){0,1}2[0-9]-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])|(20){0,1}2[0-9]/(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01]))');
  var firstMatch = regex.firstMatch(str);
  try {
    yyMMdd = firstMatch.input.substring(firstMatch.start, firstMatch.end);
  } catch (_) {
    yyMMdd = "not detected";
  }

  print('날짜: $yyMMdd');

  return yyMMdd;
}

// 유종 인식
String _detectFuelType(String str) {
  String fuelType = "";

  var regex = new RegExp(r'(경유|휘발유|고급휘발유)');
  var firstMatch = regex.firstMatch(str);
  try {
    fuelType = firstMatch.input.substring(firstMatch.start, firstMatch.end);
  } catch (_) {
    fuelType = "not detected";
  }

  print('유종: $fuelType');

  return fuelType;
}

// 단가, 수량 인식 후 총액 계산
List<num> _detectNumInfo(String str) {
  List<num> numInfos = [];
  int unitPrice = 0;
  double numItems = 0;

  var regex = new RegExp(r'([0-9]{1,3},+?[0-9]{3}|[0-9]{1,3}\.+?[0-9]{1,3})');
  var allMatches = regex.allMatches(str);
  for (RegExpMatch m in allMatches) {
    String match = m[0];
    String finalMatch = match.replaceAll(',', '');
    double matchToNum = double.parse(finalMatch);
    //print(matchToNum);
    if (matchToNum >= 1000 && matchToNum <= 2000) {
      if (matchToNum == matchToNum.floor()) {
        unitPrice = matchToNum.floor();
      }
    } else if (matchToNum <= 100) {
      numItems = matchToNum;
    }
  }
  numInfos.add(unitPrice);
  numInfos.add(numItems);
  numInfos.add((unitPrice * numItems).floor());

  print('단가: $unitPrice, 수량: $numItems, 총액: ${(unitPrice * numItems).floor()}');

  return numInfos;
}

class ImageAndCamera extends StatefulWidget {
  @override
  ImageAndCameraState createState() => ImageAndCameraState();
}

class ImageAndCameraState extends State<ImageAndCamera> {
  File mPhoto;

  final List<FuelInformation> _fuelInformations = [];

  void _addFuelInformations(String str) {
    final newFI = FuelInformation(
      date: null,
      fuelType: _detectFuelType(str),
      unitPrice: _detectNumInfo(str)[0],
      quantity: _detectNumInfo(str)[1],
      totalPrice: _detectNumInfo(str)[2],
    );

    setState(() {
      _fuelInformations.add(newFI);
    });
  }

  Future visionAPICall() async {
    List<int> imageBytes = mPhoto.readAsBytesSync();
    //print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    //print(base64Image);
    final _request_str = {
      "requests": [
        {
          "image": {"content": "$base64Image"},
          "features": [
            {
              "type": "TEXT_DETECTION",
              "maxResults": 1,
            }
          ],
        }
      ]
    };

    var url = Uri.parse(
        'https://vision.googleapis.com/v1/images:annotate?key=AIzaSyDtG8TAiP0xFYTNAle4DP2UfEGYqtAlzPM');
    var response = await http.post(url, body: json.encode(_request_str));
    //print('Response body: ${response.body}');

    var responseJson = json.decode(response.body);
    //print(responseJson);
    var str =
        '${responseJson["responses"][0]["textAnnotations"][0]["description"]}';
    // print(str);

    // //실제로 인식한 영수증 sample text
    // var str1 =
    //     "상품명(주유기) 단가 수량\n보통휘발유(05) 1,499 X 41.865\n(할인판매) Most 10원\n과세금액\n금액\n62,755\n57,050 부가세액\n5,705\n[Most결제내역]\n예약\n총할인액\n예약결제액\n100,000\n-3,667\n96,333\n예약\n부분취소\n실주유금액\n100,000\n-36,826\n63,174\n[단가할인]\nMost 할인\n[금액할인]\n(-10원/L) -419\n-3,004\n-3,423\nОСВ\n할인총액\n최종결제액\n59,751\n[신용카드 곁제취소 (예정) 내역]\n기존 신용카드 결제액(예약결제액) 96,333\n결제취소(예정)\n계\n-36,582\n59,751\n※ 주유할인 신용카드 및 간편결제는\n청구할인 예정\n※ 주유총액 : 63,175원(41.865L)\n(단가할인으로 주유기 표시액과 상이)\n※ 스탬프 2개 적립완료\n※ 결제취소(예정) 36,582원은 2\"3일내\n취소 예정\n";
    // var str2 =
    //     "[매출전표(승인)]\n사업자: 238-42-00226 전화: 053-965-5152\n상 호: 계명2주유소\n주소: 대구 동구 이노밸리로 277\n인쇄: 2021-04-04 15:22:33\n대표: 이덕렬\n상품명\n단가\n수량\n금액\n주유기 : #06/06 경유\n1004\n1,318 59.94 79,000\n공급가액 :\n세 액 :\n71,818\n7,182\n합계금액\n현대개인!\n[신용승인(고객용)]\n카드번호 : 9490-88*- -9335 (**/**)\n가맹점NO : 411833002\n승 인 NO : 00591248\n승인일시 : 21/04/04 15:22:32\n매입사: 현대카드\n결재방법 : 일시불\n일련번호 :\n거래번호 : 4039\n감사합니다.!\n\u003c알림\u003e\n* 원거래 승인금액은 취소 되었습니다.\n* 승인금액 : 150,000\n* 승인번호 :00068443\n승인시간 :210404152020\n\u003c원거래취소\u003e\n* 취소금액 : 150,000\n* 취소시간 :210404152232\n감사합니다.!\n";
    // var str3 = "";
    //InputFuelInfo(str);
  }

  @override
  Widget build(BuildContext context) {
    Widget photo = (mPhoto != null) ? Image.file(mPhoto) : Text('Empty');

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          //버튼을 제외한 영역의 가운데 출력
          Expanded(
            child: Center(child: photo),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () => onPhoto(ImageSource.gallery),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                  ),
                  child: Text('Album')),
              ElevatedButton(
                onPressed: visionAPICall,
                child: Text('Test'),
              ),
              ElevatedButton(
                  onPressed: () => onPhoto(ImageSource.camera),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                  ),
                  child: Text('Camera')),
            ],
          ),
        ],
      ),
    );
  } // build

  // 앨범과 카메라 양쪽에서 호출
  void onPhoto(ImageSource source) async {
    final _picker = ImagePicker();
    PickedFile f = await _picker.getImage(source: source);
    setState(() {
      mPhoto = File(f.path);
    });
  }
}
