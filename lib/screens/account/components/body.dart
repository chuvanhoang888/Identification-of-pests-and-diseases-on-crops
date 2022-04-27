import 'package:cached_network_image/cached_network_image.dart';
import 'package:diacritic/diacritic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/model/post_model_1.dart';
import 'package:project_detect_disease_datn/screens/account/profile_account/profile_account.dart';
import 'package:project_detect_disease_datn/screens/communication/components/detail_posts.dart';
import 'package:project_detect_disease_datn/screens/communication/components/post_container.dart';
import 'package:project_detect_disease_datn/screens/sign_in/sign_in_screen.dart';
import 'package:project_detect_disease_datn/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:project_detect_disease_datn/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  List<Post> postList = [];
  List<Post> listSearch = [];
  List<Post> reversedPosts = [];

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
        // reversedPosts = postList.reversed.toList();
        listRiceSearch();
        setState(() => isLoading = false);
      });
    });
  }

  List<Post> listRiceSearch() {
    //Get values từ cái thanh search, Bỏ hết dấu đi, So sánh với cái list bệnh
    listSearch.clear();
    for (Post posts in postList) {
      //Hàm remove nớ là bỏ dấu đó
      //Nếu rice name trong list có cái nào chứa (giống) values search thì add vô list mới
      if (removeDiacritics(posts.userId)
          .contains(removeDiacritics(user!.uid))) {
        listSearch.add(posts);
      }
    }
    return listSearch;
  }

  @override
  void initState() {
    super.initState();
    if (user != null) {
      getListRiceDisease();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: AccountSignIn(),
          ),
          //SizedBox(height: getProportionateScreenHeight(15)),

          user != null
              ? Container(
                  color: Colors.white,
                  child: TabBar(
                    labelStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    labelColor: kPrimaryColor,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: kPrimaryColor,
                    indicatorWeight: 3,
                    // indicator: ShapeDecoration(
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(2)),
                    // ),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                        text: "TỔNG QUÁT",
                      ),
                      user != null
                          ? Tab(
                              text: "TÔI (${listSearch.length} bài đăng)",
                            )
                          : Tab(
                              text: "TÔI",
                            ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    CardAccount(
                        logo: "assets/images/iconlogo.png",
                        title: "Cùng nhau gieo trồng thông minh!",
                        text:
                            "Chia sẻ Agdis và giúp nông dân giải quyết các vấn đề về cây trồng cua của họ.",
                        textButton: "Chia sẻ Agdis",
                        onPress: () {}),
                    CardAccount(
                        logo: "assets/images/star_edit.png",
                        title: "Agdis thích bạn rất nhiều.",
                        text:
                            "Nếu bạn cũng cảm thấy như vậy, đừng ngần ngại cho nó vài ngôi sao và một bức thư tình nhỏ trong Play Store.",
                        textButton: "Đánh giá Agdis",
                        onPress: () {})
                  ],
                ),
          user != null
              ? Expanded(
                  child: TabBarView(children: [
                    Column(
                      children: [
                        CardAccount(
                            logo: "assets/images/iconlogo.png",
                            title: "Cùng nhau gieo trồng thông minh!",
                            text:
                                "Chia sẻ Agdis và giúp nông dân giải quyết các vấn đề về cây trồng cua của họ.",
                            textButton: "Chia sẻ Agdis",
                            onPress: () {}),
                        CardAccount(
                            logo: "assets/images/star_edit.png",
                            title: "Agdis thích bạn rất nhiều.",
                            text:
                                "Nếu bạn cũng cảm thấy như vậy, đừng ngần ngại cho nó vài ngôi sao và một bức thư tình nhỏ trong Play Store.",
                            textButton: "Đánh giá Agdis",
                            onPress: () {})
                      ],
                    ),
                    user != null
                        ? Container(
                            child: ListView.builder(
                              reverse: true,
                              //controller: _scrollController,
                              padding: EdgeInsetsDirectional.zero,
                              itemCount: listSearch.length,
                              itemBuilder: (context, index) {
                                final Post post = listSearch[index];
                                //return PostContainer(post: post);
                                return isLoading
                                    ? Card(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 5.0,
                                        ),
                                        elevation: 2.0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Skelton(
                                                width: double.infinity,
                                                height:
                                                    getProportionateScreenHeight(
                                                        200)),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      10),
                                            ),
                                            Row(
                                              children: [
                                                SkeltonCircle(
                                                    width:
                                                        getProportionateScreenWidth(
                                                            50),
                                                    height:
                                                        getProportionateScreenHeight(
                                                            50)),
                                                SizedBox(
                                                  width:
                                                      getProportionateScreenWidth(
                                                          8.0),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                    width:
                                                        getProportionateScreenWidth(
                                                            5),
                                                    height:
                                                        getProportionateScreenHeight(
                                                            30))
                                              ],
                                            ),
                                            Skelton(
                                                width:
                                                    getProportionateScreenWidth(
                                                        230),
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      5),
                                            ),
                                            Skelton(
                                                width:
                                                    getProportionateScreenWidth(
                                                        210),
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      5),
                                            ),
                                            Skelton(
                                                width:
                                                    getProportionateScreenWidth(
                                                        100),
                                                height:
                                                    getProportionateScreenHeight(
                                                        10))
                                          ],
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPosts(
                                                      post: post,
                                                    ))),
                                        child: PostContainer(post: post));
                              },
                            ),
                          )
                        : Center(
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Image.asset(
                                        "assets/images/question.png")),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Vui lòng đăng nhập để xem bài đăng !",
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          )
                  ]),
                )
              : Container()
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, SplashScreen.routeName);
  }
}

class CardAccount extends StatelessWidget {
  const CardAccount({
    Key? key,
    required this.logo,
    required this.title,
    required this.text,
    required this.textButton,
    this.onPress,
  }) : super(key: key);
  final String logo;
  final String title;
  final String text;
  final String textButton;
  final VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(10)),
      child: Container(
          padding: EdgeInsets.only(
              top: getProportionateScreenHeight(15),
              left: getProportionateScreenWidth(15),
              right: getProportionateScreenWidth(15)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        //color: Color(0xFFB2DFDC),
                        borderRadius: BorderRadius.circular(5)),
                    child: SizedBox(width: 55, child: Image.asset(logo)),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(15),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: getProportionateScreenWidth(7),
                        ),
                        Text(text,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w100)),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          elevation: 0,
                          primary: kPrimaryColor,
                          backgroundColor: Colors.white,
                          // side: BorderSide(
                          //     width: 1, color: kPrimaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          //padding: EdgeInsets.symmetric(vertical: 15),
                          minimumSize: Size(100, 25)),
                      onPressed: onPress,
                      child: Text(textButton))
                ],
              )
            ],
          )),
    );
  }
}

class AccountSignIn extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  AccountSignIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        user != null
            ? Container(
                child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                    width: 90,
                    height: 100,
                    child: CachedNetworkImage(
                      imageUrl: "${user!.photoURL}",
                      fit: BoxFit.cover,
                    )),
              ))
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFFB2DFDC),
                    borderRadius: BorderRadius.circular(5)),
                child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset("assets/images/question.png")),
              ),
        SizedBox(
          width: getProportionateScreenWidth(15),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user != null ? "${user!.displayName}" : "Tài khoản của bạn",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: getProportionateScreenWidth(7),
            ),
            Text(
                user != null
                    ? "Giới thiệu bản thân"
                    : "Tham gia cộng đồng Agdis",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w100)),
            SizedBox(
              height: getProportionateScreenWidth(7),
            ),
            TextButton(
                style: TextButton.styleFrom(
                    elevation: 0,
                    primary: kPrimaryColor,
                    backgroundColor: Colors.white,
                    side: BorderSide(width: 1, color: kPrimaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    //padding: EdgeInsets.symmetric(vertical: 15),
                    minimumSize: Size(250, 40)),
                onPressed: () => user != null
                    ? Navigator.pushNamed(context, ProfileAccount.routeName)
                    : Navigator.pushNamed(context, SignInScreen.routeName),
                child: Text(
                    user != null ? "Chỉnh sửa" : "Tham gia cộng đồng Agdis"))
          ],
        )
      ],
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
