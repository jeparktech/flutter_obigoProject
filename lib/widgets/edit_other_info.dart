import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/dataBase/fuelDBHelper.dart';
import '../models/otherInfo.dart';

class EditOtherInfo extends StatefulWidget {
  final InfoType? infoType;
  const EditOtherInfo({this.infoType});

  @override
  _EditOtherInfoState createState() => _EditOtherInfoState();
}

class _EditOtherInfoState extends State<EditOtherInfo> {
  String? date;
  int? totalAmount;
  int? cm;
  String? memo;
  final formKey = GlobalKey<FormState>();

  _submitData() {
    var othersDBHelper = FuelDBHelper();
    final otherInformation = OtherInformation(
        date: date,
        totalAmount: totalAmount,
        cm: cm,
        memo: memo,
        infoType: widget.infoType);

    othersDBHelper.insertOthersInfo(otherInformation);
  }

  renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
    required Icon icon,
  }) {
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
        ),
        SizedBox(height: 5),
      ],
    );
  }

  renderButton(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        if (this.formKey.currentState!.validate()) {
          this.formKey.currentState!.save();
          _submitData();
          Navigator.of(context).pushNamed('/');
        }
      },
      child: Text('저장'),
    );
  }

  bool _isInteger(String str) {
    return int.tryParse(str) != null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      //shrinkWrap: true,
      children: [
        Form(
          key: this.formKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                renderTextFormField(
                  label: '날짜',
                  onSaved: (val) {
                    date = val;
                  },
                  validator: (val) {
                    if (!RegExp(r'202[0-9]-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])')
                            .hasMatch(val) ||
                        val.length > 10) {
                      return '잘못된 형식입니다. (YYYY-MM-DD)';
                    }
                    return null;
                  },
                  icon: Icon(Icons.date_range),
                ),
                renderTextFormField(
                  label: '누적 주행거리 (km)',
                  onSaved: (val) {
                    cm = int.parse(val);
                  },
                  validator: (val) {
                    if (!_isInteger(val)) {
                      return '숫자만 입력해주세요';
                    }
                    return null;
                  },
                  icon: Icon(Icons.drive_eta),
                ),
                renderTextFormField(
                  label: '총액',
                  onSaved: (val) {
                    totalAmount = int.parse(val);
                  },
                  validator: (val) {
                    if (!_isInteger(val)) {
                      return '숫자만 입력해주세요';
                    }
                    return null;
                  },
                  icon: Icon(Icons.attach_money),
                ),
                // 메모
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.mode_comment_outlined),
                        SizedBox(width: 10),
                        Text(
                          '메모',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Card(
                      elevation: 3,
                      child: TextFormField(
                        onSaved: (val) {
                          memo = val;
                        },
                        minLines: 1,
                        maxLines: 10,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                renderButton(context),
              ],
            ),
          ),
        )
      ],
    );
  }
}
