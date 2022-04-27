import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_detect_disease_datn/apiServices/db.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/data/data.dart';
import 'package:project_detect_disease_datn/model/disease_plants.dart';
import 'package:project_detect_disease_datn/model/menu_post.dart';
import 'package:project_detect_disease_datn/model/post_model_1.dart';
import 'package:project_detect_disease_datn/screens/communication/components/menu_post_item.dart';
import 'package:project_detect_disease_datn/screens/communication/components/profile_avatar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_detect_disease_datn/screens/communication/components/update_post.dart';
import 'package:project_detect_disease_datn/screens/home/components/detail_disease_plants.dart';
import 'package:project_detect_disease_datn/size_config.dart';
import 'package:project_detect_disease_datn/utils/ProgressHuD.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:neon/neon.dart';

class PostContainer extends StatefulWidget {
  final Post post;

  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  int _current = 0;
  bool isLoading = false;

  List<DiseasePlants> dataDisease = [];
  Future<void> getdataDisease() async {
    await Future.delayed(Duration(seconds: 1), () {});
    FirebaseDatabase.instance
        .reference()
        .child("Disease_Ex")
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        //print(snapshot.value);
        var keys = snapshot.value.keys;
        var data = snapshot.value;
        dataDisease.clear();

        for (var individualKey in keys) {
          DiseasePlants dataD =
              new DiseasePlants.fromValues(data[individualKey]);

          dataDisease.add(dataD);
        }
      }
    }).whenComplete(() {});
  }

  @override
  void initState() {
    super.initState();
    getdataDisease();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        inAsyncCall: isLoading,
        opacity: 0.1,
        child: Card(
          margin: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 5.0,
          ),
          elevation: 1.0,
          //shape: null,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            //padding: const EdgeInsets.symmetric(vertical: 8.0),

            child: Column(
              children: [
                widget.post.images != null
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        // child: CachedNetworkImage(
                        //   imageUrl: post.images[0],
                        //   height: getProportionateScreenHeight(230),
                        //   width: double.infinity,
                        //   fit: BoxFit.cover,
                        // ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            builImages(),
                            widget.post.images.length > 1
                                ? buildIndicator()
                                : Container()
                          ],
                        )
                        //child: Image.network(post.imageUrl),
                        )
                    : const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _PostHeader(post: widget.post),
                      const SizedBox(height: 10.0),
                      // _PostDetect(post: post),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/find-bug2.svg",
                            color: Colors.black,
                            width: 25,
                            height: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Đã phát hiện bệnh: "),
                          InkWell(
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                if (dataDisease != null) {
                                  dataDisease.forEach((element) {
                                    if (widget.post.idDisease ==
                                        element.idDisease) {
                                      DiseasePlants plant = new DiseasePlants(
                                        describe: element.describe,
                                        enName: element.enName,
                                        viName: element.viName,
                                        idCategoriesPlant:
                                            element.idCategoriesPlant,
                                        idDisease: element.idDisease,
                                      );
                                      setState(() {
                                        isLoading = false;
                                      });
                                      print(element.idDisease);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailDiseasePlant(
                                                    title: plant.viName,
                                                    content: plant.describe,
                                                  )));
                                    } else {
                                      print("mmm");
                                    }
                                  });
                                }
                              },
                              // child: RichText(
                              //   text: TextSpan(
                              //       text: "Đã phát hiện bệnh: ",
                              //       style: TextStyle(color: Colors.black),
                              //       children: [

                              //         TextSpan(
                              //             text: "${widget.post.nameDisease}",
                              //             style: TextStyle(color: kPrimaryColor))
                              //       ]),
                              // ),
                              child: BlinkText(
                                '${widget.post.nameDisease}',
                                style: TextStyle(
                                    fontSize: 17.0, color: kPrimaryColor),
                                beginColor: Colors.red,
                                endColor: Colors.orange,
                                //times: 10,
                                //duration: Duration(seconds: 1)),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.post.title,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        widget.post.content,
                        style:
                            TextStyle(color: Color(0xFF5F7D8E), fontSize: 16),
                      ),

                      widget.post.images != null
                          ? const SizedBox.shrink()
                          : const SizedBox(height: 6.0),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  child: _PostStats(post: widget.post),
                ),
              ],
            ),
          ),
        ));
  }

  Container builImages() {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
            enableInfiniteScroll: false,
            aspectRatio: 1.8,
            autoPlay: false,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
        items: widget.post.images.map((item) {
          return Builder(
            builder: (BuildContext context) {
              //return item.image.toString();
              return ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Center(
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ))),
                  imageUrl: item,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Positioned buildIndicator() {
    return Positioned(
      bottom: 15,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: widget.post.images.map((url) {
            int index = widget.post.images
                .indexOf(url); // trả về chỉ số của mảng 0,1,2,3...
            // return Text(_current == index ? "$index" : "");
            return Container(
              width: _current == index ? 10 : 7,
              height: _current == index ? 10 : 7,
              margin: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                  //border: Border.all(color: Colors.white),
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.orange : Colors.white),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _PostHeader extends StatefulWidget {
  final Post post;

  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<_PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<_PostHeader> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: widget.post.userPhoto),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${widget.post.timeAgo} • ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        PopupMenuButton<MenuPost>(
            padding: EdgeInsets.zero,
            child: Container(
              height: 36,
              width: 48,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.more_vert,
              ),
            ),
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
                  ...user!.uid == widget.post.userId
                      ? MenuPostItems.itemsFirst.map(buildItem).toList()
                      : MenuPostItems2.itemsFirst.map(buildItem).toList(),
                  //PopupMenuDivider(),
                  //...MenuItems.itemsFirst.map(buildItem).toList(),
                ])
      ],
    );
  }

  PopupMenuItem<MenuPost> buildItem(MenuPost item) => PopupMenuItem<MenuPost>(
        value: item,
        child: Row(
          children: [
            Icon(
              item.icon,
              color: kPrimaryColor,
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              item.text,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ],
        ),
      );

  void onSelected(BuildContext context, MenuPost item) {
    switch (item) {
      case MenuPostItems.itemEdit:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UpdatePost(
                      post: widget.post,
                    )));
        break;
      case MenuPostItems.itemDelete:
        showDialog(text: "Bạn sẽ xóa bài viết này !");
        break;
      case MenuPostItems2.itemReport:
        break;
    }
  }

  void showDialog({String? text}) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100,
            child: SizedBox.expand(
                child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset("assets/images/question.png"),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text!,
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Thoát",
                              style: TextStyle(color: Colors.red),
                            )),
                        TextButton(
                            onPressed: () async {
                              bool delete = await DBServices()
                                  .deletePosts(widget.post.postKey);
                              if (delete) {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              "Xóa bài viết",
                              style: TextStyle(color: kPrimaryColor),
                            ))
                      ],
                    )
                  ],
                ))
              ],
            )),
            margin: EdgeInsets.only(bottom: 100, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}

// class _PostDetect extends StatelessWidget {
//   final Post post;
//   _PostDetect({Key? key, required this.post}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     switch (post.idDease) {
//       case 1: return Container(
//         child: Row(
//           children: [
//             Text("Phát hiện bệnh:"),
//             InkWell(
//               onTap: () {},
//               child: Text("")

//             )
//           ],
//         ),
//       );
//       case 2:

//               default:
//             }

//   }
// }

class _PostStats extends StatefulWidget {
  final Post post;

  _PostStats({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<_PostStats> createState() => _PostStatsState();
}

class _PostStatsState extends State<_PostStats> {
  final User? user = FirebaseAuth.instance.currentUser;
  Color likeColor = Color(0xFF627C8B);
  Color dislikeColor = Color(0xFF627C8B);
  Color basicColor = Color(0xFF627C8B);

  @override
  Widget build(BuildContext context) {
    if (widget.post.likes.contains(user?.uid)) {
      setState(() {
        likeColor = Color(0xFF1EE4B1);
        dislikeColor = Color(0xFF627C8B);
      });
    } else if (widget.post.dislikes.contains(user?.uid)) {
      setState(() {
        dislikeColor = Color(0xFFF95049);
        likeColor = Color(0xFF627C8B);
      });
    } else {
      setState(() {
        likeColor = Color(0xFF627C8B);
        dislikeColor = Color(0xFF627C8B);
      });
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Container(
            //   padding: const EdgeInsets.all(4.0),
            //   decoration: BoxDecoration(
            //     color: Palette.facebookBlue,
            //     shape: BoxShape.circle,
            //   ),
            //   child: const Icon(
            //     Icons.thumb_up,
            //     size: 10.0,
            //     color: Colors.white,
            //   ),
            // ),
            // const SizedBox(width: 4.0),
            // Expanded(
            //   child: Text(
            //     '${post.likes}',
            //     style: TextStyle(
            //       color: Colors.grey[600],
            //     ),
            //   ),
            // ),
            Text(
              '${widget.post.comments} bình luận',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            // const SizedBox(width: 8.0),
            // Text(
            //   '${widget.post.shares} Shares',
            //   style: TextStyle(
            //     color: Colors.grey[600],
            //   ),
            // )
          ],
        ),
        const Divider(),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _PostButton(
                icon: Icon(
                  MdiIcons.thumbUp,
                  color: likeColor,
                  size: 20.0,
                ),
                label: widget.post.likes.length > 0
                    ? '${widget.post.likes.length}'
                    : 'Thích',
                onTap: () async {
                  if (user != null) {
                    if (widget.post.likes.contains(user?.uid)) {
                      setState(() {
                        likeColor = Color(0xFF1EE4B1);
                        dislikeColor = Color(0xFF627C8B);
                      });
                    } else if (widget.post.dislikes.contains(user?.uid)) {
                      setState(() {
                        dislikeColor = Color(0xFFF95049);
                        likeColor = Color(0xFF627C8B);
                      });
                    } else {
                      setState(() {
                        likeColor = Color(0xFF627C8B);
                        dislikeColor = Color(0xFF627C8B);
                      });
                    }
                    if (widget.post.likes.contains(user!.uid)) {
                      widget.post.likes.remove(user!.uid);
                    } else if (widget.post.dislikes.contains(user!.uid)) {
                      widget.post.dislikes.remove(user!.uid);
                      widget.post.likes.add(user!.uid);
                    } else {
                      widget.post.likes.add(user!.uid);
                    }
                    await DBServices().updatePosts(widget.post);
                  } else {
                    Fluttertoast.showToast(
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        msg: "Vui lòng đăng nhập để thực hiện chức năng này !");
                  }
                }),
            SizedBox(
              width: getProportionateScreenWidth(50),
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.thumbDown,
                color: dislikeColor,
                size: 20.0,
              ),
              label: widget.post.dislikes.length > 0
                  ? '${widget.post.dislikes.length}'
                  : 'Không thích',
              onTap: () async {
                if (user != null) {
                  if (widget.post.likes.contains(user?.uid)) {
                    setState(() {
                      likeColor = Color(0xFF1EE4B1);
                      dislikeColor = Color(0xFF627C8B);
                    });
                  } else if (widget.post.dislikes.contains(user?.uid)) {
                    setState(() {
                      dislikeColor = Color(0xFFF95049);
                      likeColor = Color(0xFF627C8B);
                    });
                  } else {
                    setState(() {
                      likeColor = Color(0xFF627C8B);
                      dislikeColor = Color(0xFF627C8B);
                    });
                  }
                  if (widget.post.dislikes.contains(user!.uid)) {
                    widget.post.dislikes.remove(user!.uid);
                  } else if (widget.post.likes.contains(user!.uid)) {
                    widget.post.likes.remove(user!.uid);
                    widget.post.dislikes.add(user!.uid);
                  } else {
                    widget.post.dislikes.add(user!.uid);
                  }
                  await DBServices().updatePosts(widget.post);
                } else {
                  Fluttertoast.showToast(
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      msg: "Vui lòng đăng nhập để thực hiện chức năng này !");
                }
              },
            ),
            Spacer(),
            _PostButton(
              icon: Icon(
                MdiIcons.shareVariant,
                color: basicColor,
                size: 25.0,
              ),
              label: '',
              onTap: () => print('Share'),
            )
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback onTap;

  const _PostButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            // padding: const EdgeInsets.symmetric(
            //   horizontal: 5.0,
            // ),
            height: 30.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                label != "" ? const SizedBox(width: 4.0) : Container(),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// class _PostButton extends StatelessWidget {
//   final Icon icon;
//   final String label;
//   final VoidCallback onTap;

//   const _PostButton({
//     Key? key,
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Material(
//         color: Colors.white,
//         child: InkWell(
//           onTap: onTap,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             height: 30.0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 icon,
//                 const SizedBox(width: 4.0),
//                 Text(label),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
