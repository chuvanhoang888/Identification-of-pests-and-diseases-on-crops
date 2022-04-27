import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_detect_disease_datn/components/custom_bottom_nav_bar.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/model/post_model_1.dart';
import 'package:project_detect_disease_datn/screens/account/account_screen.dart';
import 'package:project_detect_disease_datn/screens/communication/components/detail_posts.dart';
import 'package:project_detect_disease_datn/screens/communication/components/notification_screen.dart';
import 'package:project_detect_disease_datn/screens/communication/components/post_container.dart';
import 'package:project_detect_disease_datn/screens/communication/components/upload_post.dart';
import 'package:project_detect_disease_datn/screens/search/search_screen.dart';
import 'package:project_detect_disease_datn/size_config.dart';

class CommunicationScreen extends StatefulWidget {
  static String routeName = "/communication";
  const CommunicationScreen({Key? key}) : super(key: key);
  static const IconData bell = IconData(0xf3e1);
  @override
  _CommunicationScreenState createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  final _scrollController = new TrackingScrollController();
  bool isFAB = false;
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference databaseReference;
  List<Post> postList = [];
  List<Post> reversedPosts = [];
  bool isLoading = false;

  Future<void> getListRiceDisease() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 1), () {});
    FirebaseDatabase.instance
        .reference()
        .child("Posts")
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        var keys = snapshot.value.keys;
        var data = snapshot.value;
        postList.clear();

        for (var individualKey in keys) {
          Post postData = new Post.fromValues(data[individualKey]);
          setState(() {
            postList.add(postData);
          });
        }
      }
    }).whenComplete(() {
      setState(() {
        reversedPosts = postList.reversed.toList();
        setState(() => isLoading = false);
      });
    });
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset > 50.0) {
        setState(() {
          isFAB = true;
        });
      } else {
        setState(() {
          isFAB = false;
        });
      }
    });
    super.initState();
    getListRiceDisease();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Color(0xFFEFF3F5),
        floatingActionButton: Container(
            height: 50,
            child: FittedBox(child: isFAB ? buildFAB() : buildExtendedFAB())),
        // bottomNavigationBar: CustomBottomNavBar(
        //   selectedMenu: MenuState.message,
        // ),
        // body: CustomScrollView(
        //   //controller: _scrollController,

        //   slivers: [
        //     SliverAppBar(
        //       backwardsCompatibility:
        //           false, //Phải có cái này mới dùng được SystemUiOverlayStyle
        //       systemOverlayStyle: SystemUiOverlayStyle(
        //           statusBarIconBrightness: Brightness.light,
        //           statusBarColor: Color(0xFFC6C9C7)),
        //       snap: true,
        //       floating: true,
        //       backgroundColor: Colors.white,
        //       elevation: 10,
        //       automaticallyImplyLeading: false,
        //       title: _buildInputSearch(),
        //       actions: [
        //         _buildIconButton(
        //             icon: Icons.notifications_none_outlined,
        //             notification: 0,
        //             onPressed: () {}),
        //         _buildIconButton(
        //           icon: Icons.more_vert,
        //           notification: 0,
        //           onPressed: () {},
        //         ),
        //       ],
        //     ),
        //     SliverList(
        //       delegate: SliverChildBuilderDelegate(
        //         (context, index) {
        //           final Post post = postList[index];
        //           return RefreshIndicator(
        //               triggerMode: RefreshIndicatorTriggerMode.onEdge,
        //               edgeOffset: 20,
        //               color: kPrimaryColor,
        //               backgroundColor: Colors.white,
        //               onRefresh: _refresh,
        //               child: InkWell(
        //                   onTap: () => Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => DetailPosts(
        //                                 post: post,
        //                               ))),
        //                   child: PostContainer(post: post)));
        //         },
        //         childCount: postList.length,
        //       ),
        //     ),
        //   ],
        // ),
        body: NestedScrollView(
            reverse: false,
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    snap: true,
                    floating: true,
                    backgroundColor: Colors.white,
                    elevation: 3,
                    automaticallyImplyLeading: false,
                    title: _buildInputSearch(),
                    actions: [
                      _buildIconButton(
                          icon: Icons.notifications_none_outlined,
                          notification: 0,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, NotificationScreen.routeName);
                          }),
                      _buildIconButton(
                        icon: Icons.more_vert,
                        notification: 0,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
            body: RefreshIndicator(
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                edgeOffset: 20,
                color: kPrimaryColor,
                backgroundColor: Colors.white,
                onRefresh: _refresh,
                child: ListView.builder(
                  //reverse: true,
                  //controller: _scrollController,
                  padding: EdgeInsetsDirectional.zero,
                  itemCount: reversedPosts.length,
                  itemBuilder: (context, index) {
                    final Post post = reversedPosts[index];
                    //return PostContainer(post: post);
                    return isLoading
                        ? Card(
                            margin: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 5.0,
                            ),
                            elevation: 2.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Skelton(
                                    width: double.infinity,
                                    height: getProportionateScreenHeight(200)),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                Row(
                                  children: [
                                    SkeltonCircle(
                                        width: getProportionateScreenWidth(50),
                                        height:
                                            getProportionateScreenHeight(50)),
                                    SizedBox(
                                      width: getProportionateScreenWidth(8.0),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Skelton(
                                              width:
                                                  getProportionateScreenWidth(
                                                      100),
                                              height:
                                                  getProportionateScreenHeight(
                                                      10)),
                                          Skelton(
                                              width:
                                                  getProportionateScreenWidth(
                                                      250),
                                              height:
                                                  getProportionateScreenHeight(
                                                      10))
                                        ],
                                      ),
                                    ),
                                    Skelton(
                                        width: getProportionateScreenWidth(5),
                                        height:
                                            getProportionateScreenHeight(30))
                                  ],
                                ),
                                Skelton(
                                    width: getProportionateScreenWidth(230),
                                    height: getProportionateScreenHeight(10)),
                                SizedBox(
                                  height: getProportionateScreenHeight(5),
                                ),
                                Skelton(
                                    width: getProportionateScreenWidth(210),
                                    height: getProportionateScreenHeight(10)),
                                SizedBox(
                                  height: getProportionateScreenHeight(5),
                                ),
                                Skelton(
                                    width: getProportionateScreenWidth(100),
                                    height: getProportionateScreenHeight(10))
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPosts(
                                          post: post,
                                        ))),
                            child: PostContainer(post: post));
                  },
                ))));
  }

  Future<void> _refresh() {
    return Future.delayed(Duration(seconds: 1), () {
      getListRiceDisease();
    });
  }

  Widget buildFAB() => AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.edit),
        onPressed: () {
          if (user != null) {
            Navigator.pushNamed(context, UploadPost.routeName);
          } else {
            Fluttertoast.showToast(
                msg: "Vui lòng đăng nhập để thực hiện chức năng này !",
                textColor: Colors.black,
                backgroundColor: Colors.white);
            //Navigator.pushNamed(context, AccountScreen.routeName);
          }
        },
      ));

  Widget buildExtendedFAB() => AnimatedContainer(
        duration: Duration(milliseconds: 200),
        child: FloatingActionButton.extended(
          backgroundColor: kPrimaryColor,
          label: Text(
            "Hỏi Cộng đồng",
            style: TextStyle(fontSize: 13),
          ),
          icon: Icon(Icons.edit),
          onPressed: () {
            if (user != null) {
              Navigator.pushNamed(context, UploadPost.routeName);
            } else {
              Fluttertoast.showToast(
                  msg: "Vui lòng đăng nhập để thực hiện chức năng này !",
                  textColor: Colors.black,
                  backgroundColor: Colors.white);
              //Navigator.pushNamed(context, AccountScreen.routeName);
            }
          },
        ),
      );
  _buildInputSearch() {
    final sizeicon = BoxConstraints(minWidth: 40, minHeight: 40);
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black54, width: 0),
    );
    //borderRadius: const BorderRadius.all(const Radius.circular(30.0)));
    return Row(
      children: [
        Expanded(
          child: Container(
            // decoration: BoxDecoration(boxShadow: [
            //   BoxShadow(
            //     color: Colors.black38,
            //     blurRadius: 25,
            //     offset: const Offset(0, 5), // changes position of shadow
            //   )
            // ]),
            child: TextField(
              onSubmitted: (value) {},
              onTap: () {
                Navigator.pushNamed(context, SearchScreen.routeName);
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  isDense: true,
                  enabledBorder: border,
                  focusedBorder: border,
                  hintText: "Tìm kiếm bài viết",
                  hintStyle: TextStyle(fontSize: 15, color: Colors.black26),
                  prefixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 3.0, end: 3.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: SvgPicture.asset(
                            "assets/icons/search_2.svg",
                            color: Colors.black,
                          ),
                          width: 15,
                          height: 15,
                        ),
                      )),
                  prefixIconConstraints: sizeicon,
                  filled: true,
                  fillColor: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  _buildIconButton(
      {VoidCallback? onPressed, IconData? icon, int notification = 0}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 10),
        // padding:
        //     EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),

        child: Stack(
          children: [
            Icon(
              icon,
              color: Colors.black54,
              size: 25,
            ),
            // SvgPicture.asset(
            //   icon!,
            //   color: Colors.black54,
            //   width: 25,
            //   height: 25,
            // ),
            notification != 0
                ? Positioned(
                    top: -2,
                    right: -5,
                    child: Container(
                      //margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      //constraints: BoxConstraints(minWidth: 25, minHeight: 25),
                      child: Text(
                        notification.toString() +
                            (notification > 100 ? "+" : ""),
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      //constraints: BoxConstraints(minHeight: 15, maxHeight: 15),
                    ),
                  )
                : Text("")
          ],
        ),
      ),
    );
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
