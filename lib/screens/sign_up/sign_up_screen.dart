import 'package:project_detect_disease_datn/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/body.dart';

class SignUpscreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop,
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        backwardsCompatibility:
            false, //Phải có cái này mới dùng được SystemUiOverlayStyle
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Color(0xFFC6C9C7)),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              "Đăng ký Agdis",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
                width: 25,
                height: 25,
                child: Image.asset("assets/images/iconlogo.png"))
          ],
        ),
        //centerTitle: true,
      ),
      body: Body(),
    );
  }
}
