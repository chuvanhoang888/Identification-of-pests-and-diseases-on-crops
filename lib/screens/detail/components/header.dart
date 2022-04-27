import 'package:project_detect_disease_datn/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatefulWidget {
  final TrackingScrollController scrollController;
  const Header(this.scrollController);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Color? _backgroundColor;
  Color? _backgroundColorSearch;
  Color? _colorIcon;
  Color? _backgroundColorIcon;
  Color? _colorHintText;
  Color? _colorPrefixIcon;
  late double _opacity;
  late double _offset;
  final _opacityMax = 0.01;
  @override
  void initState() {
    _backgroundColor = Colors.transparent;
    _backgroundColorSearch = Colors.transparent;
    _backgroundColorIcon = Colors.black;
    _colorIcon = Colors.white;
    _colorHintText = Colors.transparent;
    _colorPrefixIcon = Colors.transparent;
    _opacity = 0.0;
    _offset = 0.0;
    widget.scrollController.addListener(_onScroll);
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: _backgroundColorIcon),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 23,
                      color: _colorIcon,
                    ),
                  )),
              _buildInputSearch(),
              _buildIconButton(
                icon: "assets/icons/share (2).svg",
                notification: 0,
                onPressed: () {},
              ),
              _buildIconButton(
                icon: "assets/icons/trolley.svg",
                notification: 99,
                onPressed: () {},
              ),
              _buildIconButton(
                icon: "assets/icons/more.svg",
                notification: 0,
                onPressed: () {},
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
        borderRadius: const BorderRadius.all(const Radius.circular(30.0)));
    return Expanded(
      child: Container(
        // decoration: BoxDecoration(boxShadow: [
        //   BoxShadow(
        //     color: Colors.black38,
        //     blurRadius: 25,
        //     offset: const Offset(0, 5), // changes position of shadow
        //   )
        // ]),
        child: TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              isDense: true,
              enabledBorder: border,
              focusedBorder: border,
              hintText: "Tìm kiếm thêm trên shop",
              hintStyle: TextStyle(fontSize: 15, color: _colorHintText),
              prefixIcon: Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 3.0, end: 3.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: SvgPicture.asset(
                        "assets/icons/search_2.svg",
                        color: _colorPrefixIcon,
                      ),
                      width: 15,
                      height: 15,
                    ),
                  )),
              prefixIconConstraints: sizeicon,
              filled: true,
              fillColor: _backgroundColorSearch),
        ),
      ),
    );
  }

  _buildIconButton(
      {VoidCallback? onPressed, String? icon, int notification = 0}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(left: 10),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: _backgroundColorIcon),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: SvgPicture.asset(
                icon!,
                color: _colorIcon,
                width: 25,
                height: 25,
              ),
            ),
            notification != 0
                ? Positioned(
                    top: 2,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                      decoration: BoxDecoration(
                        color: kPrimaryColor2,
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
      ),
    );
  }

  void _onScroll() {
    final scrollOffset = widget.scrollController.offset;
    if (scrollOffset >= _offset && scrollOffset > 5) {
      _opacity = double.parse((_opacity + _opacityMax).toStringAsFixed(2));
      if (_opacity >= 1.0) {
        _opacity = 1.0;
      }
    } else if (scrollOffset < 100) {
      _opacity = double.parse((_opacity - _opacityMax).toStringAsFixed(2));
      if (_opacity <= 1.0) {
        _opacity = 0.0;
      }
    }
    setState(() {
      if (scrollOffset <= 0) {
        _backgroundColorSearch = Colors.transparent;
        _backgroundColorIcon = kPrimaryColor2;
        _colorIcon = Colors.white;
        _colorHintText = Colors.transparent;
        _colorPrefixIcon = Colors.transparent;
        _offset = 0.0;
        _opacity = 0.0;
      } else {
        _backgroundColorSearch = Colors.grey[100];
        _backgroundColorIcon = Colors.transparent;
        _colorIcon = kPrimaryColor2;
        _colorHintText = kSecondaryColor;
        _colorPrefixIcon = kPrimaryColor2;
      }
      _backgroundColor = Colors.white.withOpacity(_opacity);
    });
  }
}
