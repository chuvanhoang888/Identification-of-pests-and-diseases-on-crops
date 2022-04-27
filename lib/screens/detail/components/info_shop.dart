import 'package:project_detect_disease_datn/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoShop extends StatelessWidget {
  const InfoShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verticalDivider = VerticalDivider(
        indent: 10,
        endIndent: 10,
        thickness: 1,
        width: 10,
        color: Colors.grey[300]);
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(alignment: Alignment.bottomCenter, children: [
                SizedBox(
                  width: 65,
                  height: 65,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://scontent.fdad3-3.fna.fbcdn.net/v/t1.6435-9/194380617_1131923747307202_3493422250147172080_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=d-ou9gC9BvoAX_B0AQl&_nc_ht=scontent.fdad3-3.fna&oh=91a150d8ca92f95767aa60ed3947de5d&oe=6156C3E1"),
                  ),
                ),
                _buildShopRecommended()
              ]),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "hiennguyenchuyensiaothun90",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Online 3 phút trước",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Location point.svg",
                        width: 10,
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Hà Nội',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              fontWeight: FontWeight.w300))
                    ],
                  )
                ],
              ),
              Spacer(),
              TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(50, 30),
                    // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: kPrimaryColor,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(2)),
                  ),
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Text(
                      "Xem Shop",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "171",
                      style: TextStyle(color: kPrimaryColor, fontSize: 18),
                    ),
                    Text(
                      "Sản Phẩm",
                      style: TextStyle(color: Colors.grey[500]),
                    )
                  ],
                ),
                verticalDivider,
                Column(
                  children: [
                    Text(
                      "4.8",
                      style: TextStyle(color: kPrimaryColor, fontSize: 18),
                    ),
                    Text(
                      "Đánh giá",
                      style: TextStyle(color: Colors.grey[500]),
                    )
                  ],
                ),
                verticalDivider,
                Column(
                  children: [
                    Text(
                      "96%",
                      style: TextStyle(color: kPrimaryColor, fontSize: 18),
                    ),
                    Text(
                      "Phản hồi Chat",
                      style: TextStyle(color: Colors.grey[500]),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildShopRecommended() => Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          "Yêu thích",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      );
}
