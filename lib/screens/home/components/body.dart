import 'package:project_detect_disease_datn/model/main_menu_model.dart';
import 'package:project_detect_disease_datn/screens/home/components/banner_slider.dart';
import 'package:project_detect_disease_datn/viewmodels/main_menu_view_model.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          //BannerSection(),
          MainMenu(),
        ],
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  final List<MainMenuModel> _menus = MainMenuViewModel().getMainMenu();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 1.25),
            itemBuilder: (context, index) {
              final MainMenuModel menu = _menus[index];
              return Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    child: Image.asset(menu.image!),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    menu.title!,
                    style: TextStyle(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              );
            },
            itemCount: _menus.length,
          ),
        ),
      ],
    );
  }
}
