import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/model/history.dart';
import 'package:project_detect_disease_datn/screens/home/components/detail_disease_plants.dart';
import 'package:project_detect_disease_datn/size_config.dart';

class HistoryList extends StatefulWidget {
  static String routeName = "/history_list";
  const HistoryList({Key? key}) : super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  List<History> dataHistory = [];
  // get categories plant
  Future<void> getdataHistory() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1), () {});
    FirebaseDatabase.instance
        .reference()
        .child("History_EX")
        .child(user!.uid)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        var keys = snapshot.value.keys;
        var data = snapshot.value;

        dataHistory.clear();
        for (var individualKey in keys) {
          History dataHist = new History.fromValues(data[individualKey]);
          setState(() {
            dataHistory.add(dataHist);
          });
        }
      }
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    getdataHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        titleSpacing: 0,
        title: Text(
          "Lịch sử nhận dạng",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: dataHistory.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio:
                      3 / 2, //width/height cua the ProductItemCard
                  crossAxisCount: 2,
                  mainAxisSpacing: 5, // khoangr cách trục đứng
                  crossAxisSpacing: 5
                  //     5, // Khoảng cách trục chéo (tức trục ngang nếu listview xổ từ trên xuống)
                  ),
              // shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final historys = dataHistory[index];
                return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailDiseasePlant(
                                  title: historys.viName,
                                  content: historys.describe,
                                ))),
                    child: HistoryItem(history: historys));
              }),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final History history;
  const HistoryItem({required this.history});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(120),
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
          Container(
            width: double.infinity,
            height: double.maxFinite,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  "${history.viName}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "${history.date}",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
