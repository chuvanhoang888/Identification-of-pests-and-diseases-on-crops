import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_detect_disease_datn/model/list_rice_diease_data.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  static String routeName = "/detail";
  RiceDisease _riceDisease;
  DetailScreen(this._riceDisease);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return widget._riceDisease == null
        ? Scaffold(
            body: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Text(
                widget._riceDisease.name != null
                    ? widget._riceDisease.name
                    : "Data null",
                style: TextStyle(
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                //width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget._riceDisease.images),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitWidth)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(40))),
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: 20, right: 20, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/doctor1.png",
                                    height: 90,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Column(
                                    //cross giups đưa chữ về đầu dòng bên trái
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget._riceDisease.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: kTextColor),
                                      ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      Text(
                                        "Giới thiệu - Nguyên nhân - Biện pháp",
                                        style: TextStyle(
                                            color: kTitleTextColor
                                                .withOpacity(0.7)),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color:
                                                    kBlueColor.withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(2)),
                                            child: SvgPicture.asset(
                                                "assets/icons/Phone.svg"),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: kYellowColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(2)),
                                            child: SvgPicture.asset(
                                                "assets/icons/chat.svg"),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: kOrangeColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(2)),
                                            child: SvgPicture.asset(
                                                "assets/icons/video.svg"),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Giới thiệu",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: kTextColor),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              ExpandableText(
                                widget._riceDisease.describe,
                                expandText: "Xem thêm",
                                collapseText: "Rút gọn",
                                maxLines: 3,
                                linkColor: kPrimaryColor,
                                style: TextStyle(
                                    height: 1.6,
                                    color: kTitleTextColor.withOpacity(0.7)),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Nguyên nhân",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: kTextColor),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              ExpandableText(
                                widget._riceDisease.reasons,
                                expandText: "Xem thêm",
                                collapseText: "Rút gọn",
                                maxLines: 3,
                                linkColor: kPrimaryColor,
                                style: TextStyle(
                                    height: 1.6,
                                    color: kTitleTextColor.withOpacity(0.7)),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Giải pháp",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: kTextColor),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              ExpandableText(
                                widget._riceDisease.solution,
                                expandText: "Xem thêm",
                                collapseText: "Rút gọn",
                                linkColor: kPrimaryColor,
                                maxLines: 4,
                                style: TextStyle(
                                    height: 1.6,
                                    color: kTitleTextColor.withOpacity(0.7)),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ));
  }
}
