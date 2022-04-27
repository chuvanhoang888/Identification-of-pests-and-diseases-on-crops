import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_detect_disease_datn/size_config.dart';

import '../constants.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    this.image,
    this.title,
    this.text,
    this.press,
  }) : super(key: key);
  final String? image;
  final String? title;
  final String? text;
  final VoidCallback? press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: SizedBox(
          child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        alignment: Alignment.centerLeft,
        height: getProportionateScreenHeight(140),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //       offset: Offset(0, 8), blurRadius: 24, color: kShadowColor)
          // ]
        ),
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 9.0, vertical: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  width: getProportionateScreenWidth(110),
                  height: getProportionateScreenHeight(130),
                  child: Image.network(
                    image!,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              height: getProportionateScreenHeight(140),
              width: MediaQuery.of(context).size.width - 167,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                  Text(
                    text!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset(
                          "assets/icons/forward.svg",
                          color: kBlueLightColor_2,
                        )),
                  )
                ],
              ),
            ))
          ],
        ),
      )),
    );
  }
}
