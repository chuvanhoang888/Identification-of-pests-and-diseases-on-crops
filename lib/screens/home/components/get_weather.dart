import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_detect_disease_datn/components/default_button.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/screens/home/components/weather_detail.dart';
import 'package:project_detect_disease_datn/size_config.dart';

class GetWeather extends StatelessWidget {
  const GetWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(15),
          vertical: getProportionateScreenHeight(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thời tiết",
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
                //color: Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 0.5, color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, -15),
                      blurRadius: 30,
                      color: Color(0xFFDADADA).withOpacity(0.15))
                ]),
            child: InkWell(
              splashColor: kPrimaryColor,
              onTap: () =>
                  Navigator.pushNamed(context, WeatherDetail.routeName),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hôm nay, 23 thg 1",
                              style: TextStyle(fontSize: 13),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Text(
                              "32.1°C",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 23,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Text(
                              "Mặt trời lặn 17:19",
                              style: TextStyle(
                                  //fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Container(
                          width: 100,
                          child: Image.asset(
                              "assets/images/vec_weather_heavycloud.png")),
                    ],
                  ),
                  Divider(
                    color: Colors.black26,
                    height: 5,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Độ ẩm cao và có mây suốt cả ngày.",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                              child: Image.asset(
                                  "assets/images/vec_weather_heavycloud.png"),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(5),
                            ),
                            Text(
                              "42%",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Hôm nay không thích hợp để: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              // '${Format().currency(products[index].price, decimal: false)}',
                              "sử dụng thuốc trừ sâu".toUpperCase(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
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
