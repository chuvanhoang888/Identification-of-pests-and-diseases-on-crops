import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_detect_disease_datn/screens/page_view/page_view.dart';

import '../../constants.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop,
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        actions: [
          Center(
            child: InkWell(
              child: Text(
                "bỏ qua",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pushNamed(context, PagesView.routeName);
              },
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
        backwardsCompatibility:
            false, //Phải có cái này mới dùng được SystemUiOverlayStyle
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Color(0xFFC6C9C7)),
        backgroundColor: Colors.white,
        //centerTitle: true,
        title: Row(
          children: [
            Text(
              "Tham gia Agdis",
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
      ),
      body: Body(),
    );
  }
}
