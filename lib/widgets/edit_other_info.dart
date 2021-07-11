import 'package:flutter/material.dart';
import 'package:flutter_obigoproject/models/otherInfo.dart';

class EditOtherInfo extends StatefulWidget {
  const EditOtherInfo({Key? key, InfoType? infoType}) : super(key: key);

  @override
  _EditOtherInfoState createState() => _EditOtherInfoState();
}

class _EditOtherInfoState extends State<EditOtherInfo> {
  final formKey = GlobalKey<FormState>();
  renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
    required Icon icon,
    required String? initialValue,
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
          controller: TextEditingController(text: initialValue),
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

          Navigator.of(context).pushNamed('/');
        }
      },
      child: Text('저장'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
