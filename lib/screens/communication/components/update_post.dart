import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project_detect_disease_datn/apiServices/db.dart';
import 'package:project_detect_disease_datn/components/form_error.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/data/data.dart';
import 'package:project_detect_disease_datn/model/categories_plant.dart';
import 'package:project_detect_disease_datn/model/post_model_1.dart';
import 'package:project_detect_disease_datn/screens/page_view/page_view.dart';
import 'package:project_detect_disease_datn/size_config.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_store;
import 'package:path/path.dart' as Path;
import 'package:project_detect_disease_datn/utils/ProgressHuD.dart';
import 'package:intl/date_symbol_data_local.dart';

class UpdatePost extends StatefulWidget {
  static String routeName = "/update_post";
  final Post post;
  const UpdatePost({Key? key, required this.post}) : super(key: key);

  @override
  _UpdatePostState createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  String? title;
  String? content;
  String nameDialogCategories = "";
  int idCategories = 0;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  List<File> _image0 = [];
  List<String> imagesUrl = [];
  List<dynamic> imageEdit = [];
  late firebase_store.Reference ref;
  late CollectionReference imgRef;
  final picker = ImagePicker();
  bool uploading = false;
  double val = 0;
  late DateFormat dateFormat;
  bool isCategories = false;
  List<CategoriesPlant> dataCategoriesPlants = [];
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

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('vi');
    getdataCategoriesPlants();
    setState(() {
      idCategories = widget.post.idCategories;
      nameDialogCategories = widget.post.nameCategories;
    });
    imagesUrl = widget.post.images;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF3F5),
      appBar: AppBar(
        elevation: 2,
        backwardsCompatibility:
            false, //Phải có cái này mới dùng được SystemUiOverlayStyle
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xFFC6C9C7),
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.grey,
          ),
        ),
        titleSpacing: 0,
        title: Text("${widget.post.title}",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.black)),
        actions: [
          TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  if (widget.post.images.isNotEmpty && idCategories > 0) {
                    setState(() {
                      uploading = true;
                      widget.post.content = content!;
                      widget.post.title = title!;
                      widget.post.idCategories = idCategories;
                      widget.post.nameCategories = nameDialogCategories;
                    });
                    await DBServices()
                        .updatePosts(widget.post)
                        .whenComplete(() {
                      setState(() {
                        uploading = false;
                      });
                      Navigator.pushNamed(context, PagesView.routeName);
                      Fluttertoast.showToast(msg: "Đăng bài thành công :)");
                    });
                  } else {
                    idCategories > 0
                        ? Fluttertoast.showToast(msg: "Vui lòng chọn ảnh :)")
                        : Fluttertoast.showToast(
                            msg: "Vui lòng thêm cây trồng");
                  }

                  //   uploadFile().whenComplete(() =>
                  //       Navigator.pushNamed(
                  //           context, CommunicationScreen.routeName));
                  // });
                }
              },
              child: Text("Gửi", style: TextStyle(color: kPrimaryColor)))
        ],
      ),
      body: SingleChildScrollView(
          child: ProgressHUD(
              inAsyncCall: uploading,
              opacity: 0.1,
              child: Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: DottedBorder(
                              strokeWidth: 1,
                              dashPattern: [5, 4],
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              color: kPrimaryColor,
                              child: Container(
                                width: double.infinity,
                                height: getProportionateScreenHeight(250),
                                child: GridView.builder(
                                    itemCount: imagesUrl.length + 1,
                                    // có 2 hình ảnh thì độ dài+1 là 3 ==> chừa ra vị trí 0 cho dấu cộng lúc này chuỗi List<File> đã bị +1
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3),
                                    itemBuilder: (context, index) {
                                      //print(_image.toList());
                                      return index == 0
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: DottedBorder(
                                                  strokeWidth: 1,
                                                  dashPattern: [5, 5],
                                                  borderType: BorderType.RRect,
                                                  radius: Radius.circular(10),
                                                  color: kPrimaryColor,
                                                  child: Container(
                                                    child: Center(
                                                      child: IconButton(
                                                          onPressed: () =>
                                                              uploading
                                                                  ? null
                                                                  : chooseImage()
                                                                      .whenComplete(
                                                                          () {
                                                                      uploadFiles(
                                                                              _image0)
                                                                          .then(
                                                                              (value) {
                                                                        value.map(
                                                                            (e) {
                                                                          setState(
                                                                              () {
                                                                            imagesUrl.add(e);
                                                                          });
                                                                        });
                                                                      });
                                                                      print(
                                                                          imagesUrl);
                                                                    }),
                                                          icon: Icon(
                                                            Icons.add,
                                                            color:
                                                                kPrimaryColor,
                                                          )),
                                                    ),
                                                  )),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: CachedNetworkImage(
                                                imageUrl: imagesUrl[index - 1],
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child: SizedBox(
                                                            width: 20,
                                                            height: 20,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  kPrimaryColor,
                                                            ))),
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.maxFinite,
                                              ),
                                            );
                                    }),
                              ))),
                      Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Câu hỏi của bạn cho cộng đồng",
                                style: TextStyle(fontSize: 16),
                              ),
                              buildFirstitleFormField()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(
                          10,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mô tả vấn đề của bạn",
                                style: TextStyle(fontSize: 16),
                              ),
                              buildFirstNameFormField()
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: FormError(errors: errors),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cải thiện hiệu suất nhận được câu trả lời đúng",
                              style: TextStyle(fontSize: 13),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(
                                15,
                              ),
                            ),
                            idCategories > 0
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black26, width: 1)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "$nameDialogCategories",
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            onPressed: () {
                                              setState(() {
                                                idCategories = 0;
                                                nameDialogCategories = "";
                                              });
                                            },
                                            icon: Icon(
                                              Icons.cancel,
                                              color: kPrimaryColor,
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                  )
                                : TextButton(
                                    style: TextButton.styleFrom(
                                        elevation: 0,
                                        primary: Colors.white,
                                        backgroundColor: Color(0xFFEFF3F5),
                                        side: BorderSide(
                                            width: 1, color: Colors.black26),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        //padding: EdgeInsets.symmetric(vertical: 15),
                                        minimumSize: Size(120, 40)),
                                    onPressed: () {
                                      openDialog();
                                    },
                                    child: Text(
                                      "Thêm cây trồng",
                                      style: TextStyle(color: Colors.black),
                                    ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(100),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }

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
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  isDense: true,
                  enabledBorder: border,
                  focusedBorder: border,
                  hintText: "Nhập để tìm kiếm",
                  hintStyle: TextStyle(fontSize: 15, color: Colors.black26),
                  prefixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 3.0, end: 3.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: SvgPicture.asset(
                            "assets/icons/search_2.svg",
                            color: kPrimaryColor,
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

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            insetPadding: EdgeInsets.all(15),
            contentPadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chọn cây trồng của bạn",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                _buildInputSearch(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            content: Builder(
              builder: (context) {
                // Get available height and width of the build area of this widget. Make a choice depending on the size.
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;

                return Container(
                  color: Color(0xFFEFF3F5),
                  height: height - 50,
                  width: width - 50,
                  child: GridView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: dataCategoriesPlants.length,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:
                            2 / 2.5, //width/height cua the ProductItemCard
                        crossAxisCount: 3,
                        // mainAxisSpacing: 10, // khoangr cách trục đứng
                        // crossAxisSpacing: 30
                        //     5, // Khoảng cách trục chéo (tức trục ngang nếu listview xổ từ trên xuống)
                      ),
                      // shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final historys = dataCategoriesPlants[index];
                        return InkWell(
                            splashColor: kPrimaryColor,
                            onTap: () {
                              setState(() {
                                idCategories = historys.id;
                                nameDialogCategories = historys.name;
                              });
                              Navigator.of(context).pop();
                            },
                            child: CategoriesItem(category: historys));
                      }),
                );
              },
            ),
          ));

  Future chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    //print(pickedFile!.path.toString());
    ///data/user/0/com.example.project_detect_disease_datn/cache/image_picker8534895213644557141.jpg
    setState(() {
      _image0.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLosData();
  }

  Future<void> retrieveLosData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image0.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future<List<String>> uploadFiles(List<File> _images) async {
    var imageUrls =
        await Future.wait(_images.map((_image) => uploadFile(_image)));
    print("imageUrls" + imageUrls.toString());
    return imageUrls;
  }

  Future<String> uploadFile(File _image) async {
    String fileName = Path.basename(_image.path);
    Reference imageFilePath =
        FirebaseStorage.instance.ref().child("post_images").child(fileName);
    UploadTask uploadTask = imageFilePath.putFile(_image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }

  Future<void> saveToDatabase(List<String> imagesUrl2) async {
    print('Hoang2' + imagesUrl2.toList().toString());
    var dateTime = new DateTime.now();

    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference myRef = database.reference().child("Posts").push();
    String key = myRef.key;
    User? user = FirebaseAuth.instance.currentUser;
    Post post = Post(
        postKey: key,
        title: title!,
        content: content!,
        images: imagesUrl2,
        userId: user!.uid,
        userName: user.displayName.toString(),
        userPhoto: user.photoURL.toString(),
        timeAgo: dateFormat.format(dateTime),
        likes: [],
        dislikes: [],
        comments: 0,
        shares: 0,
        idCategories: idCategories,
        nameCategories: nameDialogCategories,
        idDisease: widget.post.idDisease,
        nameDisease: widget.post.nameDisease);
    myRef.set(post.toMap());
  }

  buildFirstitleFormField() {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)));
    return TextFormField(
      initialValue: widget.post.title,
      obscureText: false,
      onSaved: (newValue) => title = newValue!,
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
        contentPadding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(20),
          //horizontal: getProportionateScreenWidth(10)),
        ),
        isDense: true,
        enabledBorder: border,
        focusedBorder: border,
        filled: true,
        fillColor: Colors.white,
        hintText: "Thêm một câu hỏi cho biết vấn đề với cây trồng của bạn",
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/user.svg"),
      ),
    );
  }

  buildFirstNameFormField() {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)));
    return TextFormField(
      initialValue: widget.post.content,
      maxLines: 2,
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
        contentPadding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(20),
        ),
        isDense: true,
        enabledBorder: border,
        focusedBorder: border,
        filled: true,
        fillColor: Colors.white,
        hintText:
            "Mô tả các đặc trưng như thay đổi ở lá, màu rễ, bọ, chỗ rách...",

        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: 15,
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/user.svg"),
      ),
    );
  }
}

class CategoriesItem extends StatelessWidget {
  final CategoriesPlant category;
  const CategoriesItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.maxFinite,
      child: Column(
        children: [
          Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(shape: BoxShape.circle),
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Center(
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ))),
                  imageUrl: "${category.image}",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.maxFinite,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${category.name}",
            style: TextStyle(fontSize: 13),
          )
        ],
      ),
    );
  }
}
