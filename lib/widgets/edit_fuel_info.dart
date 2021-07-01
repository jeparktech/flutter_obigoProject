import 'package:flutter/material.dart';

class EditFuelInfo extends StatefulWidget {
  final List _list;
  final Function _addFuelInfo;

  EditFuelInfo(this._addFuelInfo, this._list);

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

  void _submitData() {
    widget._addFuelInfo(
      date: _savedDate,
      fuelType: _savedFuelType,
      unitPrice: _savedUnitPrice,
      quantity: _savedQuantity,
      totalPrice: _savedTotalPrice,
    );
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
          onChanged: (value) {
            setState(() {
              _savedFuelType = value;
              widget._list[3]['fuelType'] = value;
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

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('저장 완료!')));

          _submitData(); // DB에 데이터 저장

          print(
            '********저장된 정보********\n날짜: $_savedDate, 유종: $_savedFuelType, 단가: $_savedUnitPrice, 수량: $_savedQuantity, 총액: $_savedTotalPrice',
          );
        }
        setState(() {});
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
    return Form(
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
              initialValue: widget._list[4]['date'],
            ),
            renderDropDownButtonForFuelType(
                fuelTypeList: _fuelTypeList,
                icon: Icon(Icons.local_gas_station),
                label: '유종',
                selectedFuelType: widget._list[3]['fuelType']),
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
              initialValue: widget._list[0]['unitPrice'].toString(),
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
              initialValue: widget._list[1]['quantity'].toString(),
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
              initialValue: widget._list[2]['totalPrice'].toString(),
            ),
            renderButton(context),
          ],
        ),
      ),
    );
  }
}
