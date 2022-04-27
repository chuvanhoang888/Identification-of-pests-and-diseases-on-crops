import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';
import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility:
            false, //Phải có cái này mới dùng được SystemUiOverlayStyle
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Color(0xFF1E2440)),
        backgroundColor: kPrimaryColor2,
        title: Text(
          "Đăng ký",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
