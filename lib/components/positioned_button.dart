import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class PositionedButton extends StatelessWidget {
  const PositionedButton({
    Key? key,
    this.icon,
    this.notification,
    this.press,
  }) : super(key: key);
  final String? icon;
  final int? notification;
  final VoidCallback? press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Stack(
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              icon!,
              color: Colors.black,
            ),
          ),
          notification != 0
              ? Positioned(
                  top: 5,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    //constraints: BoxConstraints(minWidth: 25, minHeight: 25),
                    child: Text(
                      notification.toString() + "+",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    //constraints: BoxConstraints(minHeight: 15, maxHeight: 15),
                  ),
                )
              : Text("")
        ],
      ),
    );
  }
}
