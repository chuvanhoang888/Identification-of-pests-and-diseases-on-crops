import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_detect_disease_datn/components/custom_surffix_icon.dart';
import 'package:project_detect_disease_datn/cubit/auth_cubit.dart';
import 'package:project_detect_disease_datn/screens/splash/splash_screen.dart';

import '../../../constants.dart';

class ProfileAccount extends StatefulWidget {
  static String routeName = "/profile_account";
  ProfileAccount({Key? key}) : super(key: key);

  @override
  State<ProfileAccount> createState() => _ProfileAccountState();
}

class _ProfileAccountState extends State<ProfileAccount> {
  final User? user = FirebaseAuth.instance.currentUser;

  final List<String> errors = [];

  String? name;
  String? info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Cho appbar nằm trên body trông như dùng stack
      backgroundColor: Color(0xFFEFF3F5),
      appBar: AppBar(
        leading: InkWell(
          onTap: Navigator.of(context).pop,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                    width: double.maxFinite,
                    child: Image.asset(
                      "assets/images/187163.jpg",
                      fit: BoxFit.fitWidth,
                    )),
                Positioned(
                  bottom: 10,
                  child: Center(
                    child: Card(
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        padding: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Center(
                                child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ))),
                            imageUrl: "${user!.photoURL}",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.maxFinite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Tổng quát",
                  style: TextStyle(color: kPrimaryColor, fontSize: 16),
                ),
                SizedBox(
                  height: 15,
                ),
                buildNamelFormField(),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                buildInformationFormField(),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Ngôn ngữ & quốc gia",
                  style: TextStyle(color: kPrimaryColor, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chọn ngôn ngữ Agdis của bạn",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Việt Nam")
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Tài khoản",
                  style: TextStyle(color: kPrimaryColor, fontSize: 16),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  child: Text("Đăng xuất"),
                  onTap: () async {
                    final authCubit = BlocProvider.of<AuthCubit>(this.context);
                    await authCubit.logout();
                    Navigator.pushNamed(context, SplashScreen.routeName);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildNamelFormField() {
    return TextFormField(
        keyboardType: TextInputType.text,
        //Hàm onChanged() dùng để kiểm tra sự kiện chỉ cần chạm vào ô email là kiểm tra ngay ko cần button gì hết
        onSaved: (newValue) => name = newValue,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kEmailNullError)) {
            setState(() {
              errors.remove(kEmailNullError);
            });
          } else if (emailValidatorRegExp.hasMatch(value) &&
              errors.contains(kInvalidEmailError)) {
            setState(() {
              errors.remove(kInvalidEmailError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty && !errors.contains(kEmailNullError)) {
            setState(() {
              errors.add(kEmailNullError);
            });
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value) &&
              !errors.contains(kInvalidEmailError)) {
            setState(() {
              errors.add(kInvalidEmailError);
            });
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          labelText: "Nhập tên của bạn ",
          labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
          //labelStyle: TextStyle(color: Colors.grey),
          hintText: "${user!.displayName}",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //Bạn có thể thêm các biểu tượng trực tiếp vào TextFields. Bạn cũng có thể sử dụng prefixText và hậu tố cho văn bản thay thế.
          // prefixIcon: CustomSurffixIcon(
          //   svgIcon: "assets/icons/Mail.svg",
          // )),
        ));
  }

  TextFormField buildInformationFormField() {
    return TextFormField(
        keyboardType: TextInputType.text,
        //Hàm onChanged() dùng để kiểm tra sự kiện chỉ cần chạm vào ô email là kiểm tra ngay ko cần button gì hết
        onSaved: (newValue) => info = newValue,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kEmailNullError)) {
            setState(() {
              errors.remove(kEmailNullError);
            });
          } else if (emailValidatorRegExp.hasMatch(value) &&
              errors.contains(kInvalidEmailError)) {
            setState(() {
              errors.remove(kInvalidEmailError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty && !errors.contains(kEmailNullError)) {
            setState(() {
              errors.add(kEmailNullError);
            });
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value) &&
              !errors.contains(kInvalidEmailError)) {
            setState(() {
              errors.add(kInvalidEmailError);
            });
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          labelText: "Giới thiệu bản thân",
          labelStyle: TextStyle(color: Colors.black, fontSize: 18),
          //labelStyle: TextStyle(color: Colors.grey),
          hintText: "Viết gì đó về bạn",
          hintStyle: TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //Bạn có thể thêm các biểu tượng trực tiếp vào TextFields. Bạn cũng có thể sử dụng prefixText và hậu tố cho văn bản thay thế.
          // prefixIcon: CustomSurffixIcon(
          //   svgIcon: "assets/icons/Mail.svg",
          // )),
        ));
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, SplashScreen.routeName);
  }
}
