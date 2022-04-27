import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_detect_disease_datn/screens/sign_up/components/profile_avatar.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'sign_up_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03), // 4%

                // Text("Đăng ký tài khoản",
                //     style:
                //         TextStyle(fontSize: 23, fontWeight: FontWeight.w600)),
                // Text(
                //   "Hoàn thành thông tin chi tiết của bạn hoặc tiếp tục \n với mạng xã hội",
                //   textAlign: TextAlign.center,
                // ),

                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SocalCard(
                //       icon: "assets/icons/google-icon.svg",
                //       press: () {},
                //     ),
                //     SocalCard(
                //       icon: "assets/icons/facebook-2.svg",
                //       press: () {},
                //     ),
                //     SocalCard(
                //       icon: "assets/icons/twitter.svg",
                //       press: () {},
                //     ),
                //   ],
                // ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  'Bằng cách tiếp tục xác nhận rằng bạn đồng ý \n với Điều khoản và Điều kiện của chúng tôi',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
