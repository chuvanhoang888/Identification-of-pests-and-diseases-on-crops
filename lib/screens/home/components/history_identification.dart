import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/model/history.dart';
import 'package:project_detect_disease_datn/screens/home/components/detail_disease_plants.dart';
import 'package:project_detect_disease_datn/screens/home/components/list_history.dart';
import 'package:project_detect_disease_datn/size_config.dart';

class HistoryIdentification extends StatefulWidget {
  final List<History> history;
  const HistoryIdentification({Key? key, required this.history})
      : super(key: key);

  @override
  _HistoryIdentificationState createState() => _HistoryIdentificationState();
}

class _HistoryIdentificationState extends State<HistoryIdentification> {
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  // List<History> dataHistory = [];
  // // get categories plant
  // Future<void> getdataHistory() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await Future.delayed(Duration(seconds: 1), () {});
  //   FirebaseDatabase.instance
  //       .reference()
  //       .child("History_EX")
  //       .child(user!.uid)
  //       .once()
  //       .then((DataSnapshot snapshot) {
  //     if (snapshot.value != null) {
  //       var keys = snapshot.value.keys;
  //       var data = snapshot.value;

  //       dataHistory.clear();
  //       for (var individualKey in keys) {
  //         History dataHist = new History.fromValues(data[individualKey]);
  //         setState(() {
  //           dataHistory.add(dataHist);
  //         });
  //       }
  //     }
  //   }).whenComplete(() {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(15),
            vertical: getProportionateScreenHeight(15)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(
                "Hình ảnh gần đây",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Spacer(),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, HistoryList.routeName),
                child: Text(
                  "Xem thêm",
                  style: TextStyle(color: Color(0xFF0158DB)),
                ),
              )
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            height: getProportionateScreenHeight(90),
            color: Colors.transparent,
            child: ListView.separated(
              //padding: EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: widget.history.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                final historys = widget.history[index];
                return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailDiseasePlant(
                                  title: historys.viName,
                                  content: historys.describe,
                                ))),
                    child: HistoryItem(history: historys));
              },
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: 8),
            ),
          )
        ]));
  }
}

class HistoryItem extends StatelessWidget {
  final History history;
  const HistoryItem({required this.history});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(100),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              placeholder: (context, url) => Center(
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ))),
              imageUrl: "${history.image}",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.maxFinite,
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   height: double.maxFinite,
          //   padding: EdgeInsets.all(10),
          //   decoration: BoxDecoration(color: Colors.white.withOpacity(0.3)),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Spacer(),
          //       Text(
          //         "${history.viName}",
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis,
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       Text(
          //         "${history.date}",
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
