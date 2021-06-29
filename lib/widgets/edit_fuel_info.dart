import 'package:flutter/material.dart';

class EditFuelInfo extends StatelessWidget {
  String _savedDate;
  String _savedFuelType;
  int _savedUnitPrice;
  double _savedQuantity;
  int _savedTotalPrice;
  final List _list;
  final formKey = GlobalKey<FormState>();
  final Function _addFuelInfo;

  EditFuelInfo(this._addFuelInfo, this._list);

  void _submitData() {
    _addFuelInfo(
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
        Container(height: 5),
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
              initialValue: _list[4]['date'],
            ),
            renderTextFormField(
              icon: Icon(Icons.local_gas_station),
              label: '유종',
              onSaved: (val) {
                _savedFuelType = val;
              },
              validator: (val) {
                if (!RegExp(r'(경유|휘발유|고급휘발유)').hasMatch(val)) {
                  return '정확한 유종을 입력해주세요';
                }
                return null;
              },
              initialValue: _list[3]['fuelType'].toString(),
            ),
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
              initialValue: _list[0]['unitPrice'].toString(),
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
              initialValue: _list[1]['quantity'].toString(),
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
              initialValue: _list[2]['totalPrice'].toString(),
            ),
            renderButton(context),
          ],
        ),
      ),
    );
  }
}
