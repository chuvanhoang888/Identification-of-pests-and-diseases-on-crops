import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_detect_disease_datn/apiServices/db.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/model/comments.dart';
import 'package:project_detect_disease_datn/model/post_model_1.dart';
import 'package:project_detect_disease_datn/screens/communication/components/comment_container.dart';
import 'package:project_detect_disease_datn/size_config.dart';
import 'package:intl/intl.dart'; //for date format
import 'package:intl/date_symbol_data_local.dart';

class DetailPosts extends StatefulWidget {
  static String routeName = "/detail_posts";
  final Post post;
  DetailPosts({Key? key, required this.post}) : super(key: key);

  @override
  _DetailPostsState createState() => _DetailPostsState();
}

class _DetailPostsState extends State<DetailPosts> {
  int _current = 0;
  final _scrollController = TrackingScrollController();
  //ScrollController _sController = new ScrollController();
  final User? user = FirebaseAuth.instance.currentUser;
  List<Comments> listComments = [];
  FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference databaseReference;
  Color? _backgroundColorAppbar;
  Color? _colorIconAppbar;
  Color? _colorTitleAppbar;
  Color? _statusBarColor;
  late double _elevation;
  Brightness? _statusBarIconBrightness;
  late double _opacity;
  late double _offset;
  final _opacityMax = 0.01;
  String? content;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  late DateFormat dateFormat;
  final TextEditingController _commentsController = new TextEditingController();

  Future<void> getListComments() async {
    FirebaseDatabase.instance
        .reference()
        .child("Comments")
        .child(widget.post.postKey)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        var keys = snapshot.value.keys;
        var data = snapshot.value;
        listComments.clear();

        for (var individualKey in keys) {
          Comments commentsData = new Comments.fromValues(data[individualKey]);
          setState(() {
            listComments.add(commentsData);
          });
        }
      }
    }).whenComplete(() {
      widget.post.comments = listComments.length;
      DBServices().updatePosts(widget.post);
    });
  }

  @override
  void initState() {
    _elevation = 0.0;
    _backgroundColorAppbar = Colors.transparent;
    _colorIconAppbar = Colors.white;
    _colorTitleAppbar = Colors.transparent;
    _statusBarColor = Colors.transparent;
    _statusBarIconBrightness = Brightness.light;
    _opacity = 0.0;
    _offset = 0.0;
    _scrollController.addListener(_onScroll);
    super.initState();
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('vi');
    getListComments();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void _onScroll() {
    final scrollOffset = _scrollController.offset;
    if (scrollOffset >= _offset && scrollOffset > 300) {
      _opacity = double.parse((_opacity + _opacityMax).toStringAsFixed(2));
      if (_opacity >= 1.0) {
        _opacity = 1.0;
      }
    } else if (scrollOffset < 100) {
      _opacity = double.parse((_opacity - _opacityMax).toStringAsFixed(2));
      if (_opacity <= 1.0) {
        _opacity = 0.0;
      }
    }
    setState(() {
      if (scrollOffset <= 0) {
        _elevation = 0.0;
        _backgroundColorAppbar = Colors.transparent;
        _colorIconAppbar = Colors.white;
        _colorTitleAppbar = Colors.transparent;
        _statusBarColor = Colors.transparent;
        _statusBarIconBrightness = Brightness.light;
        _offset = 0.0;
        _opacity = 0.0;
      } else {
        _elevation = 3.0;
        _backgroundColorAppbar = Colors.white;
        _colorIconAppbar = Colors.black;
        _colorTitleAppbar = Colors.black;
        _statusBarColor = Color(0xFFC6C9C7);
        _statusBarIconBrightness = Brightness.light;
      }
      //_backgroundColorAppbar = Colors.white.withOpacity(_opacity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF3F5),
      extendBodyBehindAppBar:
          true, // Cho appbar nằm trên body trông như dùng stack
      appBar: AppBar(
        elevation: _elevation,
        backgroundColor: _backgroundColorAppbar,
        //automaticallyImplyLeading: false, // Don't show the leading button
        leading: InkWell(
          onTap: Navigator.of(context).pop,
          child: Icon(
            Icons.arrow_back,
            color: _colorIconAppbar,
          ),
        ),
        title: Text(
          "${widget.post.title}",
          style: TextStyle(color: _colorTitleAppbar, fontSize: 18),
        ),
        titleSpacing: 0,
        centerTitle: false,
        backwardsCompatibility:
            false, //Phải có cái này mới dùng được SystemUiOverlayStyle
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: _statusBarIconBrightness,
            statusBarColor: _statusBarColor),
      ),

      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(alignment: Alignment.bottomCenter, children: [
                  Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.only(bottom: 60),
                      width: double.infinity,
                      //height: getProportionateScreenHeight(300),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          builImages(),
                          widget.post.images.length > 1
                              ? buildIndicator()
                              : Container()
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 3, color: Colors.white)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                "${widget.post.userPhoto}",
                                fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "${widget.post.userName}",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${widget.post.timeAgo}",
                              style: TextStyle(
                                  color: Color(0xFF5F7D8E), fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Text(
                        "${widget.post.title}",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Text("${widget.post.content}",
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: _PostStats(post: widget.post),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(color: Color(0xFFEFF3F5)),
                  child: ListView.builder(
                      //controller: _sController,
                      padding: EdgeInsets.zero,
                      reverse: true,
                      shrinkWrap:
                          true, //Hàm tạo này thích hợp cho các khung nhìn lưới có số lượng lớn (hoặc vô hạn) con vì trình tạo chỉ được gọi cho những con thực sự hiển thị, có cái này ko phải khai báo height cho gridview khi bọc nó bằng column()
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listComments.length,
                      itemBuilder: (context, index) {
                        return CommentsContainer(
                          comments: listComments[index],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: Colors.white),
            height: 60,
            child: Row(
              children: [
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(width: 3, color: Colors.white)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: user != null
                          ? Image.network(
                              user!.photoURL.toString(),
                              fit: BoxFit.cover,
                            )
                          : Image.asset("assets/images/question.png"),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Form(
                  key: _formKey,
                  child: buildFirstNameFormField(),
                )),
                SizedBox(
                  width: 10,
                ),
                Container(
                    padding: const EdgeInsets.all(0.0),
                    width: 30.0,
                    child: IconButton(
                        iconSize: 30,
                        color: Color(0xFF5F7D8E),
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          if (user != null) {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              uploadCommentPost().whenComplete(() {
                                getListComments();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                // _sController.animateTo(
                                //   _sController.position.maxScrollExtent,
                                //   duration: Duration(seconds: 1),
                                //   curve: Curves.fastOutSlowIn,
                                // );
                                Fluttertoast.showToast(
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    msg: "Thêm bình luận thành công :)");
                              });
                            } else {
                              Fluttertoast.showToast(
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  msg: "Vui lòng nhập bình luận của bạn !");
                            }
                          } else {
                            Fluttertoast.showToast(
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                msg:
                                    "Vui lòng đăng nhập để thực hiện chức năng này !");
                          }
                        }, //
                        icon: Icon(Icons.send)))
              ],
            ))
      ]),
    );
  }

  Future<void> uploadCommentPost() async {
    var dateTime = new DateTime.now();
    print(dateFormat.format(dateTime));
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference myRef = database
        .reference()
        .child("Comments")
        .child(widget.post.postKey)
        .push();
    String key = myRef.key;
    Comments comment = Comments(
        postKey: widget.post.postKey,
        commentKey: key,
        content: content.toString(),
        userId: user!.uid,
        userImg: user!.photoURL.toString(),
        userName: user!.displayName.toString(),
        timeAgo: dateFormat.format(dateTime),
        likes: [],
        dislikes: []);
    myRef.set(comment.toMap());
    setState(() {
      _commentsController.clear();
    });
  }

  buildFirstNameFormField() {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: kSecondaryColor, width: 1),
        borderRadius: const BorderRadius.all(const Radius.circular(5.0)));
    return TextFormField(
      controller: _commentsController,
      //maxLines: 2,
      onTap: () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      },
      cursorColor: Colors.black,

      obscureText: false,
      onSaved: (newValue) => content = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kContentNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            errors.add(kContentNullError);
          });
          return "";
        }
        return null;
      },

      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(10),
            horizontal: getProportionateScreenWidth(10)),
        isDense: true,
        enabledBorder: border,
        focusedBorder: border,
        filled: true,
        fillColor: Colors.white,
        hintText: "Viết câu trả lời của bạn",

        hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 15,
            decoration: TextDecoration.none),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/user.svg"),
      ),
    );
  }

  Container builImages() {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
            enableInfiniteScroll: false,
            aspectRatio: 1.8,
            //autoPlay: true,
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
              return CachedNetworkImage(
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
            //   horizontal: 12.0,
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
