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
  final controller = CarouselController();
  int selectedImage = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildImageSlider(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(widget.product.images.length,
                    (index) => buildSmallPreview(index))
              ],
            ),
          ),
        ),
        // Row(
        //   children: [
        //     TextButton(onPressed: () => pressPrew(), child: Text("<-")),
        //     TextButton(onPressed: () => pressNext(), child: Text("->"))
        //   ],
        // )
      ],
    );
  }

  // void pressNext() =>
  //     controller.nextPage(duration: Duration(milliseconds: 500));
  // void pressPrew() =>
  //     controller.previousPage(duration: Duration(milliseconds: 500));
  CarouselSlider buildImageSlider() {
    return CarouselSlider.builder(
        carouselController: controller,
        itemCount: widget.product.images.length,
        itemBuilder: (context, index, realIndex) {
          final urlImage = widget.product.images[index].src;
          return buildImage(urlImage, index);
        },
        options: CarouselOptions(
            initialPage: 0,
            enableInfiniteScroll: false,
            aspectRatio: 1.1,
            //autoPlay: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                selectedImage = index;
              });
            }));
  }

  Widget buildImage(String urlImage, int index) => Container(
      width: double.infinity,
      child: CachedNetworkImage(
        placeholder: (context, url) => Center(
            child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ))),
        imageUrl: urlImage,
        width: double.infinity,
        fit: BoxFit.contain,
      ));
  InkWell buildSmallPreview(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
        //controller.jumpToPage(selectedImage);
        controller.animateToPage(selectedImage,
            duration: Duration(milliseconds: 400), curve: Curves.linear);
      },
      child: Container(
          height: 70,
          width: 70,
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  width: 1,
                  color: selectedImage == index
                      ? Colors.black
                      : kSecondaryColor.withOpacity(0.1))),
          child: CachedNetworkImage(
            imageUrl: widget.product.images[index].src,
            fit: BoxFit.cover,
          )),
    );
  }

  // Container _buildBanner(CarouselController buttonCarouselController) {
  //   return Container(
  //     //margin: EdgeInsets.only(bottom: 10),
  //     width: double.infinity,
  //     child: CarouselSlider(
  //       carouselController: buttonCarouselController,
  //       options: CarouselOptions(
  //           enableInfiniteScroll: false,
  //           aspectRatio: 1.1,
  //           //autoPlay: true,
  //           viewportFraction: 1.0,
  //           onPageChanged: (index, reason) {
  //             setState(() {
  //               selectedImage = index;
  //             });
  //           }),
  //       items: this.widget.product.images.map((item) {
  //         return Builder(
  //           builder: (BuildContext context) {
  //             return CachedNetworkImage(
  //               placeholder: (context, url) => Center(
  //                   child: SizedBox(
  //                       width: 20,
  //                       height: 20,
  //                       child: CircularProgressIndicator(
  //                         color: kPrimaryColor,
  //                       ))),
  //               imageUrl: "${item.src}",
  //               width: double.infinity,
  //               fit: BoxFit.contain,
  //             );
  //           },
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }

  // _buildIndicator() => ;
}
