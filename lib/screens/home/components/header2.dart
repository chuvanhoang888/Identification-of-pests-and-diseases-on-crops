import 'package:project_detect_disease_datn/components/positioned_button.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Color? _backgroundColor;
  Color? _backgroundColorSearch;

  @override
  void initState() {
    _backgroundColor = Colors.transparent;
    _backgroundColorSearch = Colors.white;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            children: [
              _buildInputSearch(),
              PositionedButton(
                icon: "assets/icons/trolley.svg",
                notification: 10,
                press: () {},
              ),
              PositionedButton(
                icon: "assets/icons/chat.svg",
                notification: 5,
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildInputSearch() {
    final sizeicon = BoxConstraints(minWidth: 40, minHeight: 40);
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
        borderRadius: const BorderRadius.all(const Radius.circular(4.0)));
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            isDense: true,
            enabledBorder: border,
            focusedBorder: border,
            hintText: "shopping",
            hintStyle: TextStyle(fontSize: 18, color: kPrimaryColor),
            prefixIcon: Icon(Icons.search),
            prefixIconConstraints: sizeicon,
            // suffixIcon: Icon(Icons.camera_alt),
            // suffixIconConstraints: sizeicon,
            filled: true,
            fillColor: _backgroundColorSearch),
      ),
    );
  }

  _buildIconButton(
      {VoidCallback? onPressed, String? icon, int notification = 0}) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              icon!,
              color: kPrimaryColor,
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
