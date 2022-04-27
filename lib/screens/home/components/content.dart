// import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
// import 'package:project_detect_disease_datn/constants.dart';
// import 'package:project_detect_disease_datn/screens/home/components/banner_slider.dart';
// import 'package:project_detect_disease_datn/screens/home/components/category_menu.dart';
// import 'package:project_detect_disease_datn/screens/home/components/flash_sale.dart';
// import 'package:project_detect_disease_datn/screens/home/components/main_menu.dart';
// import 'package:project_detect_disease_datn/screens/home/components/product_load_more.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class Content extends StatefulWidget {
//   final TrackingScrollController scrollController;

//   const Content(this.scrollController);

//   @override
//   _ContentState createState() => _ContentState();
// }

// class _ContentState extends State<Content> {
//   final _indicatorController = IndicatorController();

//   @override
//   void dispose() {
//     _indicatorController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomRefreshIndicator(
//       controller: _indicatorController,
//       onRefresh: () => Future.delayed(const Duration(seconds: 2)),
//       builder: (
//         BuildContext context,
//         Widget child,
//         IndicatorController controller,
//       ) {
//         return AnimatedBuilder(
//           animation: controller,
//           builder: (BuildContext context, _) {
//             return Stack(
//               alignment: Alignment.topCenter,
//               children: <Widget>[
//                 if (!controller.isIdle) // Nếu người dùng kéo xuống
//                   Positioned(
//                     top: 100 * controller.value,
//                     child: SizedBox(
//                       height: 30,
//                       width: 30,
//                       child: SpinKitThreeBounce(
//                         color: kPrimaryColor,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                 Transform.translate(
//                   offset: Offset(0, 155.0 * controller.value),
//                   child: child,
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       child: SingleChildScrollView(
//         controller: widget.scrollController,
//         child: Column(
//           children: [
//             BannerSection(),
//             //MainMenu(),
//             CategoryMenu(),
//             DataProductsCategories(
//                 categoriesId: 1, name: "MAINBOARD - BO MẠCH CHỦ"),
//             DataProductsCategories(
//               categoriesId: 2,
//               name: "CPU - BỘ VI XỬ LÝ",
//             ),
//             DataProductsCategories(
//               categoriesId: 3,
//               name: "RAM - BỘ NHỚ TRONG",
//             ),
//             DataProductsCategories(
//               categoriesId: 4,
//               name: "VGA - CARD MÀN HÌNH",
//             ),
//             DataProductsCategories(
//               categoriesId: 5,
//               name: "SSD - Ổ CỨNG THỂ RẮN",
//             ),
//             DataProductsCategories(
//               categoriesId: 6,
//               name: "HDD - Ổ CỨNG PC",
//             ),
//             DataProductsCategories(
//               categoriesId: 7,
//               name: "CASE - VỎ MÁY TÍNH",
//             ),
//             DataProductsCategories(
//               categoriesId: 8,
//               name: "PSU - NGUỒN MÁY TÍNH",
//             ),
//             DataProductsCategories(
//               categoriesId: 9,
//               name: "TẢN NHIỆT - FAN RGB",
//             ),
//             ProductLoadMore()
//           ],
//         ),
//       ),
//     );
//   }

//   // Container _buildDivider() => Container(
//   //       height: 14,
//   //       color: Colors.grey[200],
//   //     );
// }
