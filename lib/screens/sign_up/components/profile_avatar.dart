import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  //PickedFile _imageFile;
  File? imageFile;
  final _picker = ImagePicker();
  @override
  void initState() {
    //getValidationData();

    super.initState();
  }

  void takePhoto(ImageSource source) async {
    final picture = await _picker.getImage(source: source);
    setState(() {
      imageFile = File(picture!.path);
      //_imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<dynamic> newMethod(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Make a choice!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallary"),
                    onTap: () {
                      takePhoto(ImageSource.gallery);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      takePhoto(ImageSource.camera);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                //Thêm cái này để nó ko ăn thằng FlatButton Camera
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: imageFile == null
                        ? Image.asset("assets/images/logo.png",
                            fit: BoxFit.cover)
                        : Image.file(
                            imageFile!,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -5,
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.zero,
                          backgroundColor: Color(0xFFF5F6F9),
                        ),
                        //color: Color(0xFFF5F6F9),
                        onPressed: () => newMethod(context),
                        child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
