import 'package:flutter/material.dart';
import 'package:project_detect_disease_datn/components/custom_bottom_nav_bar.dart';
import 'package:project_detect_disease_datn/model/menu_item.dart';
import 'package:project_detect_disease_datn/screens/home/components/menu_item.dart';
import 'package:project_detect_disease_datn/screens/splash/splash_screen.dart';
import '../../enums.dart';
import 'components/body.dart';

class AccountScreen extends StatelessWidget {
  static String routeName = "/account";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xFFF5F6F9),
          appBar: AppBar(
            elevation: 3.0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Text(
              "Agdis",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              PopupMenuButton<MenuItem>(
                  onSelected: (item) => onSelected(context, item),
                  itemBuilder: (context) => [
                        ...MenuItems.itemsFirst.map(buildItem).toList(),
                        //PopupMenuDivider(),
                        //...MenuItems.itemsFirst.map(buildItem).toList(),
                      ])
            ],
          ),
          body: Body(),
          // bottomNavigationBar: CustomBottomNavBar(
          //   selectedMenu: MenuState.account,
          // ),
        ));
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) =>
      PopupMenuItem<MenuItem>(value: item, child: Text(item.text));
  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemSettings:
        Navigator.pushNamed(context, SplashScreen.routeName);
        break;
    }
  }
}
