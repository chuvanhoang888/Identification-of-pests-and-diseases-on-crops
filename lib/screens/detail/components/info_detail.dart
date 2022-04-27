import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/model/product.dart';
import 'package:project_detect_disease_datn/model/product_model.dart';
import 'package:project_detect_disease_datn/viewmodels/product_view_model.dart';
import 'package:project_detect_disease_datn/widgets/discount_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class InfoDetail extends StatefulWidget {
  final Product product;
  InfoDetail({required this.product});
  @override
  _InfoDetailState createState() => _InfoDetailState();
}

class _InfoDetailState extends State<InfoDetail> {
  //final List<ProductModel> _productViewModel = ProductViewModel().getProduct();
  final verticalDivider = VerticalDivider(
      indent: 3,
      endIndent: 3,
      thickness: 0.5,
      width: 20,
      color: Colors.grey[300]);
  int ratings = 0;

  @override
  Widget build(BuildContext context) {
    //final ProductModel product = _productViewModel[2];
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(
                      text: TextSpan(children: [
                    //if (widget.product.mall) WidgetSpan(child: _buildMall()),
                    // if (widget.product.shopRecommended)
                    //   WidgetSpan(child: _buildShopRecommended()),
                    TextSpan(
                        text: "${widget.product.name}",
                        style: TextStyle(
                            color: Colors.black, fontSize: 19, height: 1.5))
                  ])),
                ),
                SizedBox(
                  width: 15,
                ),
                if (widget.product.discountPercentage != 0)
                  _buildDiscount(widget.product.discountPercentage),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "${NumberFormat.currency(locale: 'eu', decimalDigits: 0, symbol: "").format(widget.product.price).toString()}₫",
              style: TextStyle(
                  color: kPrimaryColor2,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15,
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Rating((rating) {
                    setState(() {
                      ratings = rating;
                    });
                  }),
                  verticalDivider,
                  Text(
                    "Đã bán ${widget.product.sold}",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/heart1.svg",
                          width: 22,
                          height: 22,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        SvgPicture.asset(
                          "assets/icons/share (2).svg",
                          width: 22,
                          height: 22,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildDiscount(int discountPercentage) {
    return Container(
      width: 35,
      height: 50,
      child: CustomPaint(
        painter: DiscountPainter(),
        size: Size(35, 180),
        child: Column(
          children: [
            SizedBox(height: 3),
            Text(
              discountPercentage.toString() + "%",
              style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            Text(
              "sale",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildMall() => Container(
        margin: EdgeInsets.only(right: 5),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          "Mall",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      );

  Container _buildShopRecommended() => Container(
        margin: EdgeInsets.only(right: 5),
        padding: EdgeInsets.all(2),
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

class Rating extends StatefulWidget {
  final int maximumRating;
  final Function(int) onRatingSelected;

  Rating(this.onRatingSelected, [this.maximumRating = 5]);
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int _currentRating = 4;

  Widget _buildRatingStar(int index) {
    if (index < _currentRating) {
      return Icon(
        Icons.star,
        color: Colors.orange,
        size: 21,
      );
    } else {
      return Icon(
        Icons.star_border_outlined,
        size: 21,
      );
    }
  }

  Widget _buildBody() {
    final stars = List<Widget>.generate(this.widget.maximumRating, (index) {
      return InkWell(
        child: _buildRatingStar(index),
        onTap: () {
          setState(() {
            _currentRating = index + 1;
          });
          print(_currentRating);
          this.widget.onRatingSelected(_currentRating);
        },
      );
    });
    return Row(
      children: [
        Row(
          children: stars,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          _currentRating.toString(),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
