import 'package:flutter/material.dart';
import '../widgets/edit_other_info.dart';
import '../models/otherInfo.dart';

class EditOtherInfoPage extends StatelessWidget {
  static const routeName = '/edit-other-info';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final OtherInformation otherInfo = routeArgs['otherInfo'];
    final List<OtherInformation> otherList = routeArgs['otherList'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: EditOtherInfo(
        infoType: otherInfo.infoType,
      ),
    );
  }
}
