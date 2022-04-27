import 'package:project_detect_disease_datn/screens/account/account_screen.dart';
import 'package:project_detect_disease_datn/screens/communication/communication_screen.dart';
import 'package:project_detect_disease_datn/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);
  final MenuState selectedMenu;
  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFBDBDBD);
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(color: Colors.white,
          // borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15))
          ]),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, HomePage.routeName),
              child: Column(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      "assets/icons/plant-svgrepo-com.svg",
                      color: MenuState.home == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                    ),
                  ),
                  Text(
                    "Cây trồng",
                    style: TextStyle(
                        color: MenuState.home == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, CommunicationScreen.routeName),
              child: Column(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      "assets/icons/communication-94.svg",
                      color: MenuState.message == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                    ),
                  ),
                  Text(
                    "Cộng đồng",
                    style: TextStyle(
                        color: MenuState.message == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, AccountScreen.routeName),
              child: Column(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      "assets/icons/7518698_avatar_people_user_icon.svg",
                      color: MenuState.account == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                    ),
                  ),
                  Text(
                    "Tôi",
                    style: TextStyle(
                        color: MenuState.account == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
