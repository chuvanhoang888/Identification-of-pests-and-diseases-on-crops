import 'dart:async';

import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/screens/home/home_page.dart';
import 'package:project_detect_disease_datn/screens/page_view/page_view.dart';
import 'package:project_detect_disease_datn/size_config.dart';
import 'package:flutter/material.dart';

String? finalEmail;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // getValidationData().whenComplete(() async {
    //   var d = Duration(seconds: 2);
    //   //delayed 3 seconds to next page
    //   Timer(d, () {
    //     Navigator.pushNamed(context,
    //         finalEmail == null ? SignInScreen.routeName : HomePage.routeName);
    //   });
    // });
    var d = Duration(seconds: 2);
    //delayed 3 seconds to next page
    Timer(d, () {
      Navigator.pushNamed(context, PagesView.routeName);
    });
    super.initState();
  }

  // Future getValidationData() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   var email = sharedPreferences.getString('user_email');
  //   setState(() {
  //     finalEmail = email;
  //   });
  //   print(finalEmail);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: getProportionateScreenWidth(100),
                child: Image.asset("assets/images/iconlogo.png")),
            Text(
              "agdis",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
            Text(
              "Bác sĩ cây trồng",
              style: TextStyle(
                fontSize: 18,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
    // Dùng khi màn tai thỏ
  }
}
