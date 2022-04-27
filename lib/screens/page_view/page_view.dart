import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/screens/account/account_screen.dart';
import 'package:project_detect_disease_datn/screens/communication/communication_screen.dart';
import 'package:project_detect_disease_datn/screens/home/home_page.dart';

class PagesView extends StatefulWidget {
  static String routeName = "/pages_view";
  //final int index;
  const PagesView({
    Key? key,
  }) : super(key: key);

  @override
  _PagesViewState createState() => _PagesViewState();
}

class _PagesViewState extends State<PagesView> {
  int currentIndex = 0;
  final screens = [HomePage(), CommunicationScreen(), AccountScreen()];

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   currentIndex = widget.index;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFBDBDBD);
    return Scaffold(
        body: IndexedStack(
          children: screens,
          index: currentIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10.0,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: inActiveIconColor,
          items: [
            BottomNavigationBarItem(
                backgroundColor: kPrimaryColor,
                icon: SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      "assets/icons/plant-svgrepo-com.svg",
                      color:
                          currentIndex == 0 ? kPrimaryColor : inActiveIconColor,
                    )),
                label: "Cây trồng"),
            BottomNavigationBarItem(
                backgroundColor: kPrimaryColor,
                icon: SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      "assets/icons/communication-94.svg",
                      color:
                          currentIndex == 1 ? kPrimaryColor : inActiveIconColor,
                    )),
                label: "Cộng đồng"),
            BottomNavigationBarItem(
                backgroundColor: kPrimaryColor,
                icon: SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      "assets/icons/7518698_avatar_people_user_icon.svg",
                      color:
                          currentIndex == 2 ? kPrimaryColor : inActiveIconColor,
                    )),
                label: "Tôi")
          ],
        ));
  }
}
