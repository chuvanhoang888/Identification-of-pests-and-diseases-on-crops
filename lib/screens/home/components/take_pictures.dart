import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_detect_disease_datn/components/camera_screen.dart';
import 'package:project_detect_disease_datn/components/default_button.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/size_config.dart';

class TakePictures extends StatelessWidget {
  const TakePictures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(15),
          right: getProportionateScreenWidth(15),
          top: getProportionateScreenHeight(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chữa cho cây trồng",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(15),
                vertical: getProportionateScreenHeight(20)),
            decoration: BoxDecoration(
                color: Color(0xFFF7F7F7),
                border: Border.all(width: 0.5, color: Colors.black12),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, -15),
                      blurRadius: 30,
                      color: Color(0xFFDADADA).withOpacity(0.15))
                ]),
            child: InkWell(
              splashColor: kPrimaryColor,
              onTap: () => Navigator.pushNamed(context, CameraScreen.routeName),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                                height: getProportionateScreenHeight(60),
                                width: getProportionateScreenWidth(60),
                                child: Image.asset(
                                    "assets/images/ic_leave_picture.png")),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                        child: Image.asset(
                            "assets/images/ic_chevron_rounded_end.png"),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: getProportionateScreenHeight(60),
                                width: getProportionateScreenWidth(60),
                                child: Image.asset(
                                    "assets/images/ic_confirm_diagnosis.png")),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                        child: Image.asset(
                            "assets/images/ic_chevron_rounded_end.png"),
                      ),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                                height: getProportionateScreenHeight(60),
                                width: getProportionateScreenWidth(60),
                                child: Image.asset(
                                    "assets/images/ic_select_treatment.png")),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Chụp ảnh",
                        style: TextStyle(
                            //fontWeight: FontWeight.w200,
                            color: Colors.black),
                      ),
                      Text(
                        "Xem chẩn\nđoán",
                        style: TextStyle(
                            //fontWeight: FontWeight.w200,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Lấy thuốc",
                        style: TextStyle(
                            //fontWeight: FontWeight.w200,
                            color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  DefaultButton(
                    press: () =>
                        Navigator.pushNamed(context, CameraScreen.routeName),
                    text: "Chụp ảnh",
                    color: Color(0xFF0158DB),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
