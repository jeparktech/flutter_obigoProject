import 'package:flutter/material.dart';
import '../models/fuelInfo.dart';
import '../dataBase/fuelDBHelper.dart';

class EditFuelInfo extends StatefulWidget {
  final FuelInformation fuelInfo;
  List<FuelInformation> fuelList;
  bool isEditMode = false;

  EditFuelInfo({this.fuelInfo, this.fuelList, this.isEditMode});

  @override
  _EditFuelInfoState createState() => _EditFuelInfoState();
}

class _EditFuelInfoState extends State<EditFuelInfo> {
  String _savedDate;
  String _savedFuelType;
  int _savedUnitPrice;
  double _savedQuantity;
  int _savedTotalPrice;

  final _fuelTypeList = ['휘발유', '경유', '고급휘발유'];
  final formKey = GlobalKey<FormState>();

  int selectedIdx = 0;

  void _addFuelInfo(
      FuelInformation newFuelInfo, FuelDBHelper fuelDBHelper) async {
    await fuelDBHelper.insertFuelInfo(newFuelInfo);

    // if (newFuelInfo.date != widget.fuelInfo.date &&
    //     await fuelDBHelper.hasFuelInfo(widget.fuelInfo.date)) {
    //   fuelDBHelper.deleteFuelInfo(widget.fuelInfo.date);
    // }

    // DB에 정보가 잘 들어갔는지 확인
    List<FuelInformation> fuelInfoList = await fuelDBHelper.fuelInfos();
    for (int i = 0; i < fuelInfoList.length; i++) {
      print('Fuel Information #${i + 1}-----------------${fuelInfoList[i]}\n');
    }
  }

  void updateList(FuelInformation newFuelInfo, FuelDBHelper fuelDBHelper) {
    if (newFuelInfo.date != widget.fuelInfo.date) {
      fuelDBHelper.deleteFuelInfo(widget.fuelInfo.date);
      widget.fuelList.remove(widget.fuelInfo);
    }
  }

  void _submitData() {
    var fuelDBHelper = FuelDBHelper();
    final newFuelInfo = FuelInformation(
        date: _savedDate,
        fuelType: _savedFuelType,
        unitPrice: _savedUnitPrice,
        quantity: _savedQuantity,
        totalPrice: _savedTotalPrice);

    _addFuelInfo(newFuelInfo, fuelDBHelper);

    if (widget.isEditMode == true) {
      updateList(newFuelInfo, fuelDBHelper);

      widget.isEditMode = false;
    }
  }

  renderTextFormField({
    @required String label,
    @required FormFieldSetter onSaved,
    @required FormFieldValidator validator,
    @required Icon icon,
    @required String initialValue,
  }) {
    assert(onSaved != null);
    assert(validator != null);

    return Column(
      children: [
        Row(
          children: [
            icon,
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        TextFormField(
          onSaved: onSaved,
          validator: validator,
          controller: TextEditingController(text: initialValue),
        ),
        SizedBox(height: 5),
      ],
    );
  }

  renderDropDownButtonForFuelType(
      {@required String label,
      @required List<String> fuelTypeList,
      @required Icon icon,
      @required String selectedFuelType}) {
    _savedFuelType = selectedFuelType;
    return Column(
      children: [
        Row(
          children: [
            icon,
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        DropdownButton(
          value: selectedFuelType,
          items: fuelTypeList.map((value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
          onTap: () {
            if (this.formKey.currentState.validate()) {
              this.formKey.currentState.save();
            }
            print('button is tapped');
          },
          onChanged: (value) {
            setState(() {
              _savedFuelType = value;
              widget.fuelInfo.fuelType = value;
            });
          },
        ),
        SizedBox(height: 5),
      ],
    );
  }

  renderButton(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        if (this.formKey.currentState.validate()) {
          this.formKey.currentState.save();
          _submitData(); // DB에 데이터 저장

          print(
            '********저장된 정보********\n날짜: $_savedDate, 유종: $_savedFuelType, 단가: $_savedUnitPrice, 수량: $_savedQuantity, 총액: $_savedTotalPrice',
          );

          Navigator.of(context).pushNamed('/');
        }
      },
      child: Text('저장'),
    );
  }

  bool _isInteger(String str) {
    if (str == null) {
      return false;
    }
    return int.tryParse(str) != null;
  }

  bool _isDouble(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(15),
      children: [
        Container(
          child: Form(
            key: this.formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  renderTextFormField(
                    icon: Icon(Icons.date_range),
                    label: '날짜',
                    onSaved: (val) {
                      _savedDate = val;
                    },
                    validator: (val) {
                      if (!RegExp(r'202[0-9]-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])')
                              .hasMatch(val) ||
                          val.length > 10) {
                        return '잘못된 형식입니다. (YYYY-MM-DD)';
                      }
                      return null;
                    },
                    initialValue:
                        _savedDate == null ? widget.fuelInfo.date : _savedDate,
                  ),
                  renderDropDownButtonForFuelType(
                      fuelTypeList: _fuelTypeList,
                      icon: Icon(Icons.local_gas_station),
                      label: '유종',
                      selectedFuelType: widget.fuelInfo.fuelType),
                  renderTextFormField(
                    icon: Icon(Icons.price_check),
                    label: '단가',
                    onSaved: (val) {
                      _savedUnitPrice = int.parse(val);
                    },
                    validator: (val) {
                      if (!_isInteger(val)) {
                        return '숫자만 입력해주세요';
                      }
                      return null;
                    },
                    initialValue: _savedUnitPrice == null
                        ? widget.fuelInfo.unitPrice.toString()
                        : _savedUnitPrice.toString(),
                  ),
                  renderTextFormField(
                    icon: Icon(Icons.stacked_bar_chart),
                    label: '수량',
                    onSaved: (val) {
                      _savedQuantity = double.parse(val);
                    },
                    validator: (val) {
                      if (!_isDouble(val)) {
                        return '숫자만 입력해주세요';
                      }
                      return null;
                    },
                    initialValue: _savedQuantity == null
                        ? widget.fuelInfo.quantity.toString()
                        : _savedQuantity.toString(),
                  ),
                  renderTextFormField(
                    icon: Icon(Icons.attach_money_outlined),
                    label: '총액',
                    onSaved: (val) {
                      _savedTotalPrice = int.parse(val);
                    },
                    validator: (val) {
                      if (!_isInteger(val)) {
                        return '숫자만 입력해주세요';
                      }
                      return null;
                    },
                    initialValue: _savedTotalPrice == null
                        ? widget.fuelInfo.totalPrice.toString()
                        : _savedTotalPrice.toString(),
                  ),
                  renderButton(context),
                ],
              ),
            ),
          ),
        ),
        // Expanded(
        //   child: Center(child: photo),
        // ),
        RaisedButton(
          child: Text('이전'),
          onPressed: () {
            Navigator.of(context).pushNamed('/');
          },
        )
      ],
    );
  }
}
