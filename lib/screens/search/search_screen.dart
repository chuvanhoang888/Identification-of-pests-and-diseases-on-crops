import 'package:diacritic/diacritic.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_detect_disease_datn/model/post_model_1.dart';
import 'package:project_detect_disease_datn/screens/communication/components/detail_posts.dart';
import 'package:project_detect_disease_datn/screens/communication/components/post_container.dart';

import '../../constants.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Post> listpost = [];
  List<Post> listSearch = [];
  bool showListview = false;
  Future<void> getListPosts() async {
    listpost.clear();
    FirebaseDatabase.instance
        .reference()
        .child("Posts")
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        var keys = snapshot.value.keys;
        var data = snapshot.value;
        //print(data);
        for (var individualKey in keys) {
          Post postData = new Post.fromValues(data[individualKey]);
          setState(() {
            listpost.add(postData);
          });
        }
      }
    });
  }

  //Hàm xịn xò
  List<Post> listRiceSearch(String value) {
    //Get values từ cái thanh search, Bỏ hết dấu đi, So sánh với cái list bệnh
    listSearch.clear();
    for (Post post in listpost) {
      //Hàm remove nớ là bỏ dấu đó
      //Nếu rice name trong list có cái nào chứa (giống) values search thì add vô list mới
      if (removeDiacritics(post.title.toLowerCase())
          .contains(removeDiacritics(value))) {
        listSearch.add(post);
      }
    }
    return listSearch;
  }

  @override
  void initState() {
    super.initState();
    getListPosts();
  }

  @override
  Widget build(BuildContext context) {
    final sizeicon = BoxConstraints(minWidth: 40, minHeight: 40);
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black54, width: 0),
    );
    return Scaffold(
      backgroundColor: Color(0xFFEFF3F5),
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop()),
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      onChanged: (String value) {
                        if (value.trim().isNotEmpty) {
                          value = value.trim().toLowerCase();
                          setState(() {
                            showListview = true;
                            listSearch = listRiceSearch(value);
                          });
                        } else {
                          setState(() {
                            showListview = false;
                          });
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          isDense: true,
                          enabledBorder: border,
                          focusedBorder: border,
                          hintText: "Tìm kiếm bài viết",
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.black26),
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
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
        actions: [
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: showListview == true
            ? listSearch.length == 0
                ? Center(
                    child: Text('Không tìm thấy gì!'),
                  )
                : Container(
                    // child: ListView(
                    //padding: EdgeInsets.all(8.0),
                    //   children: listSearch.map((rice) => ItemCard()).toList(),
                    // ),
                    child: ListView.builder(
                        padding: EdgeInsetsDirectional.zero,
                        itemCount: listSearch.length,
                        itemBuilder: (context, index) {
                          final Post post = listSearch[index];
                          return InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPosts(
                                            post: post,
                                          ))),
                              child: PostContainer(post: post));
                        }))
            : Container(),
      ),
    );
  }
}
