import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_detect_disease_datn/components/default_button.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/model/categories_plant.dart';
import 'package:project_detect_disease_datn/utils/ProgressHuD.dart';

class UploadCategories extends StatefulWidget {
  static String routeName = "/upload_categories";
  const UploadCategories({Key? key}) : super(key: key);

  @override
  _UploadCategoriesState createState() => _UploadCategoriesState();
}

class _UploadCategoriesState extends State<UploadCategories> {
  bool uploading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload categories"),
        backgroundColor: Colors.black,
      ),
      body: ProgressHUD(
          inAsyncCall: uploading,
          opacity: 0.1,
          child: Center(
            child: DefaultButton(
              color: kPrimaryColor,
              press: () async {
                saveToDatabase().whenComplete(() {
                  setState(() {
                    uploading = false;
                  });
                  Fluttertoast.showToast(msg: "Upload data success :)");
                });
              },
              text: "Upload Data",
            ),
          )),
    );
  }

  Future<void> saveToDatabase() async {
    setState(() {
      uploading = true;
    });
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference myRef =
        database.reference().child("Categories_Plant").push();

    CategoriesPlant plant = CategoriesPlant(
        id: 16,
        name: "Lúa",
        color: 0xFFFECFCC,
        image:
            "https://firebasestorage.googleapis.com/v0/b/plant-e7169.appspot.com/o/users_photos%2Frice.png?alt=media&token=4d3b8b98-4e35-401e-ae78-2f3380327f61");
    myRef.set(plant.toMap());
    // CategoriesPlant plant = CategoriesPlant(
    //     id: 15,
    //     name: "Lúa",
    //     color: 0xFFFAE48E,
    //     image:
    //         "https://firebasestorage.googleapis.com/v0/b/plant-e7169.appspot.com/o/users_photos%2Frice.png?alt=media&token=4d3b8b98-4e35-401e-ae78-2f3380327f61");
    // myRef.set(plant.toMap());
  }
}
