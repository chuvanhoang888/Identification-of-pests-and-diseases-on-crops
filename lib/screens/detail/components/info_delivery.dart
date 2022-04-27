import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoDelivery extends StatelessWidget {
  const InfoDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/free-shipping-2048.svg",
                    width: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Miễn phí vận chuyển",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    "assets/icons/delivery-truck.svg",
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Phí vận chuyển:",
                        style: TextStyle(color: Colors.grey[600])),
                    TextSpan(text: "₫", style: TextStyle(color: Colors.black)),
                    TextSpan(text: "0", style: TextStyle(color: Colors.black))
                  ])),
                ],
              )
            ],
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[600],
          )
        ],
      ),
    );
  }
}
