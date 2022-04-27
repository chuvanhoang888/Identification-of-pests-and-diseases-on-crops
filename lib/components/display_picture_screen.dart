import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_detect_disease_datn/apiServices/global.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:http/http.dart' as http;
import 'package:project_detect_disease_datn/model/history.dart';
import 'package:project_detect_disease_datn/screens/home/components/detail_disease_plants.dart';
import 'package:project_detect_disease_datn/utils/progressHuD-indicator.dart';
import 'package:path/path.dart' as Path;

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  bool uploading = false;
  bool loadTitle = false;
  //String _url = "https://d23f-171-231-38-220.ngrok.io";
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  late String accuracy;
  late String date;
  late String time;
  late String describe;
  late String enName;
  late String viName;
  late String idDisease;
  late String image;
  User? user = FirebaseAuth.instance.currentUser;

  Future<String> _uploadFile(File _image) async {
    String fileName = Path.basename(_image.path);
    Reference imageFilePath =
        FirebaseStorage.instance.ref().child("history_images").child(fileName);
    UploadTask uploadTask = imageFilePath.putFile(_image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }

  Future<void> _uploadHistoryToDatabase(String urlImage) async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference myRef =
        database.reference().child("History_EX").child(user!.uid).push();
    String key = myRef.key;

    History history = History(
        accuracy: accuracy,
        date: date,
        describe: describe,
        enName: enName,
        idDisease: idDisease,
        image: urlImage,
        time: time,
        viName: viName,
        historyKey: key);
    myRef.set(history.toMap());
  }

  Future<void> _asyncFileUpload(File file) async {
    var uploadURL = "$URL_SERVER" + "/predict";
    var uri = Uri.parse(uploadURL);
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", uri);
    //add text fields
    //request.fields["text_field"] = text;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("file", file.path);
    //add multipart to request
    request.files.add(pic);

    var response = await request.send();

    //Get the response from the server
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      //final responseJson = json.decode(response.body);
      //var responseString = String.fromCharCodes(responseData);
      // var encoded = utf8.encode(responseString);
      // var decoded = utf8.decode(encoded);
      var result = jsonDecode(responseData);

      // List<String> stringList = (result as List<String>).cast<String>();
      // var result_2 = result.split("_");
      // setState(() {});
      //print(responseData);
      //print("stringList" + stringList.toString());
      //print(responseData);
      setState(() {
        accuracy = result["accuracy"];
        //print(accuracy);
        date = result["date"];
        //print(date);
        time = result["time"];
        //print(time);
        describe = result["describe"];
        //print(describe);
        enName = result["enName"];
        //print(enName);
        viName = result["viName"];
        //print(viName);
        idDisease = result["id"];
        print(idDisease);
      });
    }
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

  // _buildInputSearch() {
  //   final sizeicon = BoxConstraints(minWidth: 40, minHeight: 40);
  //   final border = OutlineInputBorder(
  //     borderSide: const BorderSide(color: Colors.black54, width: 0),
  //   );
  //   //borderRadius: const BorderRadius.all(const Radius.circular(30.0)));
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: Container(
  //           child: TextFormField(
  //             onSaved: (newValue) => _url = newValue!,
  //             onChanged: (value) {
  //               if (value.isNotEmpty) {
  //                 removeError(error: kContentNullError);
  //               }
  //               return null;
  //             },
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 setState(() {
  //                   errors.add(kContentNullError);
  //                   Fluttertoast.showToast(msg: "Vui lòng nhập host");
  //                 });
  //                 return "";
  //               }
  //               return null;
  //             },
  //             decoration: InputDecoration(
  //                 contentPadding: EdgeInsets.all(8),
  //                 isDense: true,
  //                 enabledBorder: border,
  //                 focusedBorder: border,
  //                 hintText: "Vui lòng nhập host",
  //                 hintStyle: TextStyle(fontSize: 15, color: Colors.black26),
  //                 prefixIcon: Padding(
  //                     padding: const EdgeInsetsDirectional.only(
  //                         start: 3.0, end: 3.0),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: SizedBox(
  //                         child: SvgPicture.asset(
  //                           "assets/icons/search_2.svg",
  //                           color: Colors.black,
  //                         ),
  //                         width: 15,
  //                         height: 15,
  //                       ),
  //                     )),
  //                 prefixIconConstraints: sizeicon,
  //                 filled: true,
  //                 fillColor: Colors.white),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Cho appbar nằm trên body trông như dùng stack
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        // actions: [
        //   SizedBox(
        //     width: 15,
        //   )
        // ],
        //title: Form(key: _formKey, child: _buildInputSearch()),
        titleSpacing: 0,
        backwardsCompatibility:
            false, //Phải có cái này mới dùng được SystemUiOverlayStyle
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent),
        backgroundColor: Colors.transparent,
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: ProgressHUDIndicator(
              inAsyncTitle: loadTitle,
              inAsyncCall: uploading,
              opacity: 0.2,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                width: double.infinity,
                height: double.maxFinite,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Image.file(
                    File(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )),
          Container(
            height: 130,
            child: Center(
              child: InkWell(
                onTap: () async {
                  setState(() {
                    uploading = true;
                    loadTitle = true;
                  });
                  // if (_formKey.currentState!.validate()) {
                  //   _formKey.currentState!.save();
                  //   setState(() {
                  //     uploading = true;
                  //   });
                  //   _asyncFileUpload(File(this.widget.imagePath))
                  //       .whenComplete(() {
                  //     setState(() {
                  //       uploading = false;
                  //     });
                  //   });
                  // } else {
                  //   Fluttertoast.showToast(
                  //       msg: "Vui Lòng nhập host",
                  //       textColor: Colors.black,
                  //       backgroundColor: Colors.white);
                  // }
                  if (user != null) {
                    await _asyncFileUpload(File(this.widget.imagePath))
                        .whenComplete(() {
                      _uploadFile(File(widget.imagePath)).then((value) {
                        _uploadHistoryToDatabase(value).whenComplete(() {
                          setState(() {
                            loadTitle = false;
                          });
                          var d = Duration(seconds: 2);
                          //delayed 3 seconds to next page
                          Timer(d, () {
                            setState(() {
                              uploading = false;
                            });
                          });
                          // Fluttertoast.showToast(
                          //     msg: "Đã phát hiện bệnh tiềm năng",
                          //     backgroundColor: Colors.white,
                          //     textColor: Colors.black);
                          var d2 = Duration(seconds: 2);
                          //delayed 3 seconds to next page
                          Timer(d2, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailDiseasePlant(
                                          title: viName,
                                          content: describe,
                                        )));
                          });
                        });
                      });
                    });
                  } else {
                    await _asyncFileUpload(File(this.widget.imagePath))
                        .whenComplete(() {
                      setState(() {
                        loadTitle = false;
                      });
                      var d = Duration(seconds: 2);
                      //delayed 3 seconds to next page
                      Timer(d, () {
                        setState(() {
                          uploading = false;
                        });
                      });
                      // Fluttertoast.showToast(
                      //     msg: "Đã phát hiện bệnh tiềm năng",
                      //     backgroundColor: Colors.white,
                      //     textColor: Colors.black);
                      var d2 = Duration(seconds: 2);
                      //delayed 3 seconds to next page
                      Timer(d2, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailDiseasePlant(
                                      title: viName,
                                      content: describe,
                                    )));
                      });
                    });
                  }
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Color(0xFFFF6E41),
                      borderRadius: BorderRadius.all(Radius.circular(35))),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
