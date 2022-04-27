import 'package:flutter/material.dart';
import 'package:project_detect_disease_datn/size_config.dart';
import 'package:project_detect_disease_datn/widgets/search_bar.dart';

class HeaderTop extends StatelessWidget {
  const HeaderTop({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rice Disease",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: getProportionateScreenWidth(30),
                  color: Colors.white),
            ),
            Text(
              "Scan time 10 second",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(
                width: size.width * .6,
                child: Text(
                  "Ứng dụng nhận dạng sâu bệnh trên cây lúa",
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(width: size.width * .6, child: SearchBar())
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(60),
            ),
            SizedBox(
                width: getProportionateScreenWidth(110),
                child: Image(
                    image: AssetImage(
                  "assets/images/rice.png",
                ))),
          ],
        )
      ],
    );
  }
}
