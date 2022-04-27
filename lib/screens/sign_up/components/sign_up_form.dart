import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_detect_disease_datn/components/custom_surffix_icon.dart';
import 'package:project_detect_disease_datn/components/default_button.dart';
import 'package:project_detect_disease_datn/components/form_error.dart';
import 'package:project_detect_disease_datn/model/customer.dart';
import 'package:project_detect_disease_datn/model/user_model.dart';
import 'package:project_detect_disease_datn/screens/home/home_page.dart';
import 'package:project_detect_disease_datn/screens/page_view/page_view.dart';
import 'package:project_detect_disease_datn/screens/sign_in/sign_in_screen.dart';
import 'package:project_detect_disease_datn/utils/ProgressHuD.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // User? user = FirebaseAuth.instance.currentUser;
  // UserModel loggedInUser = UserModel();

  // @override
  // void initState() {
  //   //apiService = new APIService();
  //   //model = new CustomerModel();
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     this.loggedInUser = UserModel.fromMap(value.data());
  //     setState(() {});
  //   });
  // }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, HomePage.routeName);
  }

  //PickedFile _imageFile;
  File? imageFile;
  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  late CustomerModel model;
  bool hidePassword = true;
  bool isApiCallProcess = false;
  String? email;
  String? password;
  String? conformPassword;
  String? name;
  String? phoneNumber;
  bool remember = false;
  bool isHiddenPassword1 = true;
  bool isHiddenPassword2 = true;
  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  //late APIService apiService;

  final List<String> errors = [];

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

  Future signUp(
      String email, String nameUser, String password, String phoneUser) async {
    await _mAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      Fluttertoast.showToast(
          msg: e!.message,
          textColor: Colors.black,
          backgroundColor: Colors.white);
    });
  }

  Future postDetailsToFirestore() async {
    // FirebaseStorage storage = FirebaseStorage.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    String fileName = Path.basename(imageFile!.path);
    Reference mStorage = FirebaseStorage.instance.ref().child("users_photos");
    Reference imageFilePath = mStorage.child(fileName);
    //imageFilePath.putFile(imageFile!).whenComplete(() => {});
    imageFilePath.putFile(imageFile!).then((res) async {
      String downloadUrl = await res.ref.getDownloadURL();
      print(downloadUrl);
      User? user = _mAuth.currentUser;
      user!.updatePhotoURL(downloadUrl);
      user.updateDisplayName(name);
      //user.updatePhoneNumber(phoneNumber)
      //user.updatePhoneNumber(phoneNumber);
      UserModel userModel = UserModel();
      //writing all the value
      userModel.uid = user.uid;
      userModel.email = user.email;
      userModel.name = name;
      userModel.phone = phoneNumber;
      userModel.imageUrl = downloadUrl;

      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());
    });

    // await firebaseFirestore
    //     .collection("users")
    //     .add({'email': user!.email, 'imageUrl': imageFile, 'name': name});
    // .doc(user.uid)
    // .set(userModel.toMap());
  }

  @override
  Widget build(BuildContext context) {
    var d = Duration(seconds: 5);

    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.1,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            avatarProfile(context),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            buildFirstNameFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPhoneNumberFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildConformPassFormField(),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(30)),
            DefaultButton(
              color: kPrimaryColor,
              text: "Đăng ký",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (imageFile != null) {
                    setState(() {
                      isApiCallProcess = true;
                    });
                    signUp(email!, name!, password!, phoneNumber!)
                        .whenComplete(() => {
                              postDetailsToFirestore().whenComplete(() {
                                Timer(d, () {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Đăng ký tài khoản thành công :)",
                                      textColor: Colors.black,
                                      backgroundColor: Colors.white);
                                  Navigator.pushNamed(
                                      context, SignInScreen.routeName);
                                });
                              })
                              //delayed 3 seconds to next page
                            });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Vui lòng chọn ảnh đại diện",
                        textColor: Colors.black,
                        backgroundColor: Colors.white);
                  }
                  //print(name! + email! + phoneNumber! + conformPassword!);

                  // if all are valid then go to success screen
                  // model = new CustomerModel(
                  //     name: this.name!,
                  //     email: this.email!,
                  //     phone: this.phoneNumber!,
                  //     password: this.conformPassword!);
                  // print(model.toJson());
                  // apiService.createCustomer(http.Client(), model).then((ret) {
                  //   setState(() {
                  //     isApiCallProcess = false;
                  //   });
                  //   if (ret) {
                  //     //return showDialog(text: "Tạo tài khoản thành công");
                  //     // return showDialog<String>(
                  //     //     context: context,
                  //     //     builder: (BuildContext context) => AlertDialog(
                  //     //           title: const Text('PC Store'),
                  //     //           content: const Text('Tạo tài khoản thành công'),
                  //     //           actions: <Widget>[
                  //     //             TextButton(
                  //     //               onPressed: () =>
                  //     //                   Navigator.pop(context, 'Thoát'),
                  //     //               child: const Text('Thoát'),
                  //     //             ),
                  //     //             TextButton(
                  //     //               onPressed: () =>
                  //     //                   Navigator.pop(context, 'Đồng ý'),
                  //     //               child: const Text('Đồng ý'),
                  //     //             ),
                  //     //           ],
                  //     //         ));
                  //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     //   content: Text("Sending Message" + ret.toString()),
                  //     // ));

                  //   } else {
                  //     //return showDialog(text: "Tài khoản đã tồn tại");
                  //   }
                  // });
                  //Navigator.pushNamed(context, SignInScreen.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Row avatarProfile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: InkWell(
                onTap: () => newMethod(context),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    //Thêm cái này để nó ko ăn thằng FlatButton Camera
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: imageFile == null
                            ? Image.asset(
                                "assets/images/image_processing20210907-13511-1juj33d.gif",
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
                            child: SvgPicture.asset(
                                "assets/icons/Camera Icon.svg"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // void showDialog({String? text}) {
  //   showGeneralDialog(
  //     barrierLabel: "Barrier",
  //     barrierDismissible: true,
  //     barrierColor: Colors.black.withOpacity(0.3),
  //     transitionDuration: Duration(milliseconds: 700),
  //     context: context,
  //     pageBuilder: (_, __, ___) {
  //       return Align(
  //         alignment: Alignment.bottomCenter,
  //         child: Container(
  //           height: 100,
  //           child: SizedBox.expand(
  //               child: Row(
  //             children: [
  //               SizedBox(
  //                 width: 100,
  //                 height: 100,
  //                 child: ClipRRect(
  //                     borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(40),
  //                         bottomLeft: Radius.circular(40)),
  //                     child: Image.asset("assets/images/logo.png")),
  //               ),
  //               Expanded(
  //                   child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     text!,
  //                     style: TextStyle(fontSize: 18),
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       TextButton(
  //                           onPressed: () => Navigator.pop(context),
  //                           child: Text(
  //                             "Thoát",
  //                             style: TextStyle(color: Colors.red),
  //                           )),
  //                       TextButton(
  //                           onPressed: () => Navigator.pushNamed(
  //                               context, SignInScreen.routeName),
  //                           child: Text(
  //                             "Đăng nhập",
  //                             style: TextStyle(color: kPrimaryColor),
  //                           ))
  //                     ],
  //                   )
  //                 ],
  //               ))
  //             ],
  //           )),
  //           margin: EdgeInsets.only(bottom: 20, left: 12, right: 12),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(40),
  //           ),
  //         ),
  //       );
  //     },
  //     transitionBuilder: (_, anim, __, child) {
  //       return SlideTransition(
  //         position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: isHiddenPassword2,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conformPassword) {
          removeError(error: kMatchPassError);
        }
        conformPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Nhập lại mật khẩu của bạn",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          //floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          suffixIcon: InkWell(
            onTap: () => _togglePasswordView2(),
            child: Icon(
              Icons.visibility,
              color:
                  isHiddenPassword2 == false ? kPrimaryColor : Colors.black26,
            ),
          )),
    );
  }

  void _togglePasswordView2() {
    isHiddenPassword2 = !isHiddenPassword2;
    setState(() {});
  }

  buildFirstNameFormField() {
    return TextFormField(
      obscureText: false,
      onSaved: (newValue) => name = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Tên đăng nhập",
        hintText: "Nhập tên",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        //floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/user.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      //keyboardType: TextInputType.number,
      onSaved: (newValue) => phoneNumber = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Số điện thoại",
        hintText: "Nhập số điện thoại",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        //floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/phone-call-svgrepo-com.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: isHiddenPassword1,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Password",
          hintText: "Nhập password",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          //floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          suffixIcon: InkWell(
            onTap: () => _togglePasswordView1(),
            child: Icon(
              Icons.visibility,
              color:
                  isHiddenPassword1 == false ? kPrimaryColor : Colors.black26,
            ),
          )),
    );
  }

  void _togglePasswordView1() {
    isHiddenPassword1 = !isHiddenPassword1;
    setState(() {});
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Nhập email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        //floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
