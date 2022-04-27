import 'package:project_detect_disease_datn/model/main_menu_model.dart';
import 'package:project_detect_disease_datn/viewmodels/main_menu_view_model.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  final List<MainMenuModel> _menus = MainMenuViewModel().getMainMenu();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final MainMenuModel menu = _menus[index];
              return Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F8FA), shape: BoxShape.circle),
                    child: Image.asset(menu.image!),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 75,
                    child: Text(
                      menu.title!,
                      style: TextStyle(fontSize: 11),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  )
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
