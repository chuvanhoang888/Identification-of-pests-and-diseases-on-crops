import 'package:project_detect_disease_datn/size_config.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'complete_profile_form.dart';

class Body extends StatelessWidget {
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
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("Hoàn tất hồ sơ", style: headingStyle),
                Text(
                  "Hoàn thành thông tin chi tiết của bạn hoặc tiếp tục \n với mạng xã hội",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                CompleteProfileForm(),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "Bằng cách tiếp tục xác nhận rằng bạn đồng ý \n với Điều khoản và Điều kiện của chúng tôi",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
