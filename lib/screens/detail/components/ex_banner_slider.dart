import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/model/product.dart';
import 'package:flutter/material.dart';

class BannerSectionDetail extends StatefulWidget {
  final Product product;
  BannerSectionDetail({required this.product});
  @override
  _BannerSectionDetailState createState() => _BannerSectionDetailState();
}

class _BannerSectionDetailState extends State<BannerSectionDetail> {
  // final List<String> _imglist = [
  //   'assets/images/banner_1.jpg',
  //   'assets/images/banner_2.jpg',
  //   'assets/images/banner_3.jpg',
  //   'assets/images/banner_4.jpg',
  //   'assets/images/banner_5.jpg',
  //   'assets/images/banner_6.jpg',
  //   'assets/images/banner_7.jpg',
  //   'assets/images/banner_8.jpg'
  // ];
  int? _current;
  @override
  void initState() {
    _current = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        _buildBanner(),
        _buildIndicator(),
      ],
    );
  }

  Container _buildBanner() {
    return Container(
      //margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
            enableInfiniteScroll: false,
            aspectRatio: 1,
            //autoPlay: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
        items: this.widget.product.images.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return CachedNetworkImage(
                placeholder: (context, url) => Center(
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ))),
                imageUrl: "${item.src}",
                width: double.infinity,
                fit: BoxFit.contain,
              );
            },
          );
        }).toList(),
      ),
    );
  }

  _buildIndicator() => Positioned(
        right: 10,
        bottom: 20,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  width: 1, color: kSecondaryColor.withOpacity(0.1))),
          child: Row(
            children: [
              Text((_current! + 1).toString() + "/"),
              Text(widget.product.images.length.toString())
            ],
          ),
        ),
      );
}
