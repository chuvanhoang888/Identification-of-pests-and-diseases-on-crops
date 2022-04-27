import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/model/product.dart';
import 'package:project_detect_disease_datn/screens/detail/components/banner_slider_detail.dart';
import 'package:project_detect_disease_datn/screens/detail/components/detail_product.dart';
import 'package:project_detect_disease_datn/screens/detail/components/info_delivery.dart';
import 'package:project_detect_disease_datn/screens/detail/components/info_detail.dart';
import 'package:project_detect_disease_datn/screens/detail/components/info_shop.dart';
import 'package:project_detect_disease_datn/screens/detail/components/together_more_product.dart';
import 'package:project_detect_disease_datn/screens/detail/components/together_product_shop.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Content extends StatefulWidget {
  final TrackingScrollController scrollController;
  Content({required this.scrollController, required this.product});
  final Product product;
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final _indicatorController = IndicatorController();

  @override
  void dispose() {
    _indicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verticalDivider = VerticalDivider(
        indent: 3,
        endIndent: 3,
        thickness: 0.5,
        width: 0,
        color: Colors.grey[300]);
    return CustomRefreshIndicator(
      controller: _indicatorController,
      onRefresh: () => Future.delayed(const Duration(seconds: 2)),
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, _) {
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                if (!controller.isIdle) // Nếu người dùng kéo xuống
                  Positioned(
                    top: 100 * controller.value,
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: SpinKitThreeBounce(
                        color: kPrimaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                Transform.translate(
                  offset: Offset(0, 155.0 * controller.value),
                  child: child,
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 55,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 0.5, color: Color(0xFFDFDFDF)),
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SvgPicture.asset(
              //       "assets/icons/Shop Icon.svg",
              //       color: Colors.red,
              //       width: 20,
              //       height: 20,
              //     ),
              //     Text(
              //       "Gian hàng",
              //       style: TextStyle(fontSize: 10, color: Colors.black54),
              //     )
              //   ],
              // ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/speech-bubble (1).svg",
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    "Chat",
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  )
                ],
              ),
              verticalDivider,
              TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFC5C4C7),
                        // gradient: LinearGradient(
                        //   // begin: Alignment.topLeft,
                        //   // end: Alignment(0.8,
                        //   //     0.0), // 10% of the width, so there are ten blinds.
                        //   colors: <Color>[
                        //     Color(0xFFFE8649),
                        //     //kPrimaryColor,
                        //     Color(0xFFFA5475)
                        //   ], // red to yellow
                        //   tileMode: TileMode
                        //       .repeated, // repeats the gradient over the canvas
                        // ),
                      ),
                      child: Center(
                        child: Text("Thêm vào\n giỏ hàng",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12)),
                      ))),
              TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                      decoration: BoxDecoration(
                        color: kPrimaryColor2,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Mua ngay",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                      ))),
            ],
          ),
        ),
        body: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            children: [
              BannerSectionDetail(
                product: widget.product,
              ),
              InfoDetail(
                product: widget.product,
              ),
              //InfoDelivery(),
              //InfoShop(),
              DetailProduct(
                product: widget.product,
              ),
              TogetherProductShop(),

              //TogetherMoreProduct(),
              Container(
                height: 1500,
              )
            ],
          ),
        ),
      ),
    );
  }

  // Container _buildDivider() => Container(
  //       height: 14,
  //       color: Colors.grey[200],
  //     );
}
