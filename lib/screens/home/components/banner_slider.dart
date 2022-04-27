// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:project_detect_disease_datn/apiServices/api.dart';
// import 'package:project_detect_disease_datn/constants.dart';
// import 'package:project_detect_disease_datn/model/banner.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class BannerList extends StatefulWidget {
//   final List<Banners> banners;

//   BannerList({required this.banners});

//   @override
//   _BannerListState createState() => _BannerListState();
// }

// class _BannerListState extends State<BannerList> {
//   int? _current;

//   @override
//   Widget build(BuildContext context) {
//     //print("Hoangf chu ${banners}");
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [buildBanner(), buildIndicator()],
//     );
//   }

//   Positioned buildIndicator() {
//     return Positioned(
//       bottom: 20,
//       child: Row(
//         children: widget.banners.map((url) {
//           int index =
//               widget.banners.indexOf(url); // trả về chỉ số của mảng 0,1,2,3...
//           // return Text(_current == index ? "$index" : "");
//           return Container(
//             width: 8,
//             height: _current == index ? 8 : 4,
//             margin: EdgeInsets.symmetric(horizontal: 4),
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white),
//                 shape: _current == index ? BoxShape.circle : BoxShape.rectangle,
//                 color: Colors.transparent),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Container buildBanner() {
//     return Container(
//       //margin: EdgeInsets.only(bottom: 10),
//       width: double.infinity,
//       child: CarouselSlider(
//         options: CarouselOptions(
//             aspectRatio: 1.8,
//             autoPlay: true,
//             viewportFraction: 1.0,
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _current = index;
//               });
//             }),
//         items: widget.banners.map((item) {
//           return Builder(
//             builder: (BuildContext context) {
//               //return item.image.toString();
//               return CachedNetworkImage(
//                 placeholder: (context, url) => Center(
//                     child: SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(
//                           color: kPrimaryColor,
//                         ))),
//                 imageUrl: "${item.image}",
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               );
//             },
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// class BannerSection extends StatelessWidget {
//   //final List<Banner> _imglist;

//   // @override
//   // void initState() {
//   //   current = 0;
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getBanners(http.Client()),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             print(snapshot.error);
//           }
//           return snapshot.hasData
//               ? BannerList(banners: snapshot.data as List<Banners>)
//               : Center(
//                   child: CircularProgressIndicator(
//                     color: kPrimaryColor,
//                   ),
//                 );
//         });
//   }
// }
