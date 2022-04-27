import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/model/product.dart';
import 'package:flutter/material.dart';

class DetailProduct extends StatefulWidget {
  final Product product;
  DetailProduct({required this.product});
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  bool isReadmore = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      //padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: kSecondaryColor.withOpacity(0.2)))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Row(
                children: [
                  Text(
                    "CHI TIẾT SẢN PHẨM",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15.0, left: 8.0, right: 8.0),
                  child: _buildText(widget.product.description),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isReadmore = !isReadmore;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: kSecondaryColor.withOpacity(0.2)))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            isReadmore == true ? "Rút gọn" : "Xem thêm",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text) {
    final lines = isReadmore ? null : 10;
    return Text(
      text,
      style: TextStyle(fontSize: 16),
      maxLines: lines,
    );
  }
}
