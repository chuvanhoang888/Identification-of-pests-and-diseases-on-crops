import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project_detect_disease_datn/components/custom_bottom_nav_bar.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/data/upload_data_disease_plants.dart';
import 'package:project_detect_disease_datn/model/categories_plant.dart';
import 'package:project_detect_disease_datn/model/disease_plants.dart';
import 'package:project_detect_disease_datn/model/history.dart';
import 'package:project_detect_disease_datn/model/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:project_detect_disease_datn/screens/account/components/body.dart';
import 'package:project_detect_disease_datn/screens/home/components/detail_disease_plants.dart';
import 'package:project_detect_disease_datn/screens/home/components/get_weather.dart';
import 'package:project_detect_disease_datn/screens/home/components/history_identification.dart';
import 'package:project_detect_disease_datn/screens/home/components/menu_item.dart';
import 'package:project_detect_disease_datn/screens/home/components/take_pictures.dart';
import 'package:project_detect_disease_datn/screens/splash/splash_screen.dart';
import 'package:project_detect_disease_datn/size_config.dart';

import '../../enums.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = TrackingScrollController();
  Color? colorTab;
  bool isCategories = false;
  bool isDataDisease = false;
  late int current = 0;
  List<DiseasePlants> dataPlants = [];
  List<CategoriesPlant> dataCategoriesPlants = [];

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

  // get categories plant
  Future<void> getdataCategoriesPlants() async {
    setState(() {
      isCategories = true;
    });
    await Future.delayed(Duration(seconds: 1), () {});
    FirebaseDatabase.instance
        .reference()
        .child("Categories_Plant")
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        var keys = snapshot.value.keys;
        var data = snapshot.value;

        dataCategoriesPlants.clear();
        for (var individualKey in keys) {
          CategoriesPlant dataCategories =
              new CategoriesPlant.fromValues(data[individualKey]);
          setState(() {
            dataCategoriesPlants.add(dataCategories);
          });
        }
      }
    }).whenComplete(() {
      setState(() {
        isCategories = false;
      });
    });
  }

  Future<void> getdataDiseasePlants() async {
    setState(() {
      isDataDisease = true;
    });
    await Future.delayed(Duration(seconds: 1), () {});
    FirebaseDatabase.instance
        .reference()
        .child("Disease_Ex")
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        var keys = snapshot.value.keys;
        var data = snapshot.value;

        //print("key" + keys.toString());
        //print("data" + data.toString());

        dataPlants.clear();
        for (var individualKey in keys) {
          DiseasePlants postData =
              new DiseasePlants.fromValues(data[individualKey]);
          setState(() {
            dataPlants.add(postData);
          });
        }
      }
    }).whenComplete(() {
      setState(() {
        isDataDisease = false;
      });
      //print(dataPlants);
    });
  }

  @override
  void initState() {
    colorTab = Color(0xFFFFFFFF);
    super.initState();
    getdataCategoriesPlants();
    getdataDiseasePlants();
    if (user != null) {
      getdataHistory();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void changeColor(int value) {
    // colorTab = fakeCategoriesPlant[value].color;
    current = value;
    print(colorTab);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
        length: dataCategoriesPlants.length,
        child: Scaffold(
          // bottomNavigationBar: CustomBottomNavBar(
          //   selectedMenu: MenuState.home,
          // ),

          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 3,
            backgroundColor: Colors.white,
            title: Text(
              "AGDIS",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            actions: [
              PopupMenuButton<MenuItem>(
                  onSelected: (item) => onSelected(context, item),
                  itemBuilder: (context) => [
                        ...MenuItems.itemsFirst.map(buildItem).toList(),
                        //PopupMenuDivider(),
                        //...MenuItems.itemsFirst.map(buildItem).toList(),
                      ])
            ],
          ),
          body: RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              edgeOffset: 20,
              color: kPrimaryColor,
              backgroundColor: Colors.white,
              onRefresh: _refresh,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   child: Column(
                    //     children: [
                    //       ListView.separated(
                    //           scrollDirection: Axis.horizontal,
                    //           itemBuilder: (context, index) =>
                    //               SkeltonCircle(width: 80, height: 80),
                    //           separatorBuilder: (context, index) =>
                    //               const SizedBox(width: 5),
                    //           itemCount: dataCategoriesPlants.length)
                    //     ],
                    //   ),
                    // ),
                    Container(
                        height: 85,
                        //color: Colors.black,
                        child: isCategories
                            ? ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    SkeltonCircle(width: 80, height: 80),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 5),
                                itemCount: 5)
                            : TabBar(
                                onTap: (value) {
                                  changeColor(value);
                                  setState(() {});
                                },

                                isScrollable: true,
                                indicatorWeight: 0,
                                indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(
                                    width: 0,
                                  ),
                                ),

                                labelPadding: EdgeInsets.zero,
                                indicatorPadding: EdgeInsets.zero,

                                //labelColor: Colors.black,
                                tabs: [
                                  ...dataCategoriesPlants.map((e) {
                                    int index = dataCategoriesPlants.indexOf(e);
                                    return InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: current == index
                                                ? Color(e.color)
                                                : Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(55),
                                                topRight: Radius.circular(55))),
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 3, vertical: 6),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 2,
                                                  color: Color(0xFFF2F2F2))),
                                          child: Tab(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: CachedNetworkImage(
                                                imageUrl: e.image,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()
                                ],
                              )),

                    Container(
                      height: 140,
                      child: isCategories
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      Skelton(width: 150, height: 100),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                  itemCount: 3),
                            )
                          : TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                  ...List.generate(dataCategoriesPlants.length,
                                      (int index) {
                                    //int index = fakeCategoriesPlant.indexOf(e);
                                    List<DiseasePlants> disease = dataPlants
                                        .where((element) =>
                                            element.idCategoriesPlant ==
                                            dataCategoriesPlants[index].id)
                                        .toList();

                                    return Container(
                                        height: 140,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        color: Color(
                                            dataCategoriesPlants[index].color),
                                        child: disease.isNotEmpty
                                            ? GridView.builder(
                                                itemCount: disease.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  childAspectRatio:
                                                      0.7, //width/height cua the ProductItemCard
                                                  crossAxisCount: 1,

                                                  mainAxisSpacing:
                                                      3, // khoangr cách trục đứng
                                                  // crossAxisSpacing:
                                                  //     5, // Khoảng cách trục chéo (tức trục ngang nếu listview xổ từ trên xuống)
                                                ),
                                                // shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  DiseasePlants diseases =
                                                      disease[index];
                                                  return InkWell(
                                                    onTap: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailDiseasePlant(
                                                                  title: diseases
                                                                      .viName,
                                                                  content: diseases
                                                                      .describe,
                                                                ))),
                                                    child: Card(
                                                      elevation: 2.0,
                                                      child: Container(
                                                        height: 100,
                                                        width: 200,
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Color(
                                                                      0xFFE8E8E8)),
                                                              child: SizedBox(
                                                                width: 20,
                                                                height: 20,
                                                                child: Image.asset(
                                                                    "assets/images/caterpillar.png"),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              diseases.viName,
                                                              style:
                                                                  TextStyle(),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                            : Container()
                                        // : Center(
                                        //     child: CircularProgressIndicator(
                                        //     color: Colors.white,
                                        //   ))
                                        );
                                  }).toList()
                                ]),
                    ),
                    // Container(
                    //     width: 100,
                    //     height: 100,
                    //     child: Image.asset("assets/images/potato.png")),
                    isCategories
                        ? Container(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(15),
                                right: getProportionateScreenWidth(15),
                                top: getProportionateScreenHeight(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Skelton(
                                    width: getProportionateScreenWidth(250),
                                    height: getProportionateScreenHeight(30)),
                                SizedBox(
                                  height: getProportionateScreenHeight(15),
                                ),
                                Skelton(
                                    width: getProportionateScreenWidth(
                                        double.infinity),
                                    height: getProportionateScreenHeight(170))
                              ],
                            ),
                          )
                        : TakePictures(),
                    isCategories
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(15),
                                vertical: getProportionateScreenHeight(15)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Skelton(
                                          width:
                                              getProportionateScreenWidth(240),
                                          height:
                                              getProportionateScreenHeight(30)),
                                      Spacer(),
                                      Skelton(
                                          width:
                                              getProportionateScreenWidth(100),
                                          height: 30)
                                    ],
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(15),
                                  ),
                                  Container(
                                    height: getProportionateScreenHeight(120),
                                    margin: EdgeInsets.only(top: 4),
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            Skelton(
                                              width:
                                                  getProportionateScreenWidth(
                                                      140),
                                              height:
                                                  getProportionateScreenHeight(
                                                      120),
                                            ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(width: 10),
                                        itemCount: 3),
                                  )
                                ]))
                        : dataHistory.length > 0
                            ? HistoryIdentification(history: dataHistory)
                            : Center(),
                    GetWeather(),
                  ],
                ),
              )),
        ));
  }

  Future<void> _refresh() {
    return Future.delayed(Duration(seconds: 1), () {
      getdataCategoriesPlants();
      getdataDiseasePlants();

      if (user != null) {
        getdataHistory();
      }
    });
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) =>
      PopupMenuItem<MenuItem>(value: item, child: Text(item.text));
  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemSettings:
        Navigator.pushNamed(context, UploadData.routeName);
        break;
    }
  }
}

class Skelton extends StatelessWidget {
  const Skelton({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16)),
    );
  }
}

class SkeltonCircle extends StatelessWidget {
  const SkeltonCircle({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04), shape: BoxShape.circle),
    );
  }
}
