import 'package:flutter/material.dart';
import 'package:project_detect_disease_datn/size_config.dart';

const kBackgroundColor = Color(0xFFF8F8F8);
const kActiveIconColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kBlueLightColor = Color(0xFFC7B8F5);
const kBlueLightColor_2 = Color(0xFF536DFE);
const kOrangeColor = Color(0xffEF716B);
const kYellowColor = Color(0xffFFB167);
const kBlueColor = Color(0xff4B7FFB);
const kShadowColor = Color(0xFFE6E6E6);
const kTitleTextColor = Color(0xff1E1C61);
//const kPrimaryColor = Color(0xFFFF7643);00CD66
const kPrimaryColor3 = Color(0xFF9b479f);
const kPrimaryColor =
    Color(0xFF1a6259); //Colors.red; //Color(0xFF89AFE1); //Color(0xFF008B45);
const kPrimaryColor2 = Color(0xFF1E2436);
const KPrimaryColor4 = Color(0xFF5F7D8E); // xanh xam
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFFEFF2F4);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Vui lòng nhập email của bạn";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Vui lòng nhập password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Vui lòng nhập tên của bạn";
const String kPhoneNumberNullError = "Vui lòng nhập số điện thoại";
const String kAddressNullError = "Vui lòng nhập địa chỉ cảu bạn";
const String kContentNullError = "Vui lòng nhập nội dung !";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
