// //import 'package:countdown_flutter/countdown_flutter.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:project_detect_disease_datn/apiServices/api.dart';
// import 'package:project_detect_disease_datn/constants.dart';
// import 'package:project_detect_disease_datn/model/product.dart';
// import 'package:project_detect_disease_datn/screens/detail/detail_page.dart';

// import 'package:project_detect_disease_datn/widgets/discount_painter.dart';
// import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';

// import 'package:http/http.dart' as http;

// class FlashSale extends StatelessWidget {
//   final List<Product> products;
//   final String nameCategories;
//   FlashSale({required this.products, required this.nameCategories});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//       ),
//       child: Padding(
//         padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 _buildFlashSaleImage("${this.nameCategories}"),
//                 Spacer(),
//                 _buildMoreButton(),
//               ],
//             ),
//             FlashSaleList(
//               products: this.products,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   TextButton _buildMoreButton() => TextButton(
//         onPressed: () {
//           print("click");
//         },
//         style: TextButton.styleFrom(primary: Colors.transparent),
//         child: Text(
//           "Xem thêm >",
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//       );

//   Text _buildFlashSaleImage(String name) => Text(name,
//       style: TextStyle(
//           //color: Colors.deepOrange,
//           color: kPrimaryColor,
//           fontWeight: FontWeight.w600,
//           fontSize: 16));
// }

// class FlashSaleList extends StatelessWidget {
//   final List<Product> products;
//   FlashSaleList({required this.products});
//   //final List<FlashSaleModel> _flashSaleViewModel =
//   //FlashSaleViewModel().getFlashSale();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 4),
//       height: 220.0,
//       color: Colors.transparent,
//       child: ListView.separated(
//         padding: EdgeInsets.symmetric(horizontal: 8),
//         scrollDirection: Axis.horizontal,
//         itemCount: products.length + 1,
//         itemBuilder: (
//           BuildContext context,
//           int index,
//         ) {
//           if (index == products.length) {
//             return _buildMore();
//           }
//           final product = products[index];
//           return FlashSaleItem(product);
//         },
//         separatorBuilder: (BuildContext context, int index) =>
//             SizedBox(width: 8),
//       ),
//     );
//   }

//   GestureDetector _buildMore() {
//     final Color color = Colors.deepOrange;
//     return GestureDetector(
//       onTap: () {
//         print("click");
//       },
//       child: SizedBox(
//         width: 120,
//         height: double.infinity,
//         child: Container(
//           color: Colors.white,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 45.0,
//                 height: 45.0,
//                 margin: EdgeInsets.only(bottom: 8),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(50.0),
//                   ),
//                   border: Border.all(
//                     color: color,
//                     width: 2.5,
//                   ),
//                 ),
//                 child: Icon(
//                   Icons.arrow_forward_ios,
//                   color: color,
//                 ),
//               ),
//               Text(
//                 "Xem thêm",
//                 style: TextStyle(
//                   color: color,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FlashSaleItem extends StatelessWidget {
//   final Product product;

//   const FlashSaleItem(this.product);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 150.0,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(5),
//           border: Border.all(width: 0.5, color: Colors.black12)),
//       child: InkWell(
//         onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => DetailPage(productModel: product))),
//         child: Column(
//           children: [
//             buildProductImage(),
//             Padding(
//               padding: EdgeInsets.all(5),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   buildName(),
//                   SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       buildPrice(),
//                       buildSold(),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Stack buildProductImage() {
//     return Stack(
//       children: <Widget>[
//         ClipRRect(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(6), topRight: Radius.circular(6)),
//           child: CachedNetworkImage(
//             placeholder: (context, url) => Center(
//                 child: SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(
//                       color: kPrimaryColor,
//                     ))),
//             imageUrl: "${product.images[0].src}",
//             height: 120.0,
//             fit: BoxFit.cover,
//           ),
//         ),
//         if (product.discountPercentage != 0) _buildDiscount(),
//       ],
//     );
//   }

//   Positioned _buildDiscount() => Positioned(
//         right: 0,
//         child: Container(
//           height: 180,
//           width: 38,
//           child: CustomPaint(
//             painter: DiscountPainter(),
//             size: Size(35, 180),
//             child: Column(
//               children: [
//                 SizedBox(height: 3),
//                 Text(
//                   "${product.discountPercentage}%",
//                   style: TextStyle(
//                     color: Colors.deepOrange,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 13,
//                   ),
//                 ),
//                 Text(
//                   "sale",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );

//   Text buildName() => Text(
//         '${product.name}',
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(fontWeight: FontWeight.w500),
//       );

//   RichText buildPrice() => RichText(
//         text: TextSpan(
//           text: '\đ ',
//           style: TextStyle(
//             color: Colors.deepOrange,
//             fontSize: 14,
//           ),
//           children: <TextSpan>[
//             TextSpan(
//               text:
//                   // '${Format().currency(products[index].price, decimal: false)}',
//                   '${NumberFormat.currency(locale: 'eu', decimalDigits: 0, symbol: "").format(product.price).toString()}',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       );

//   Text buildSold() => Text(
//         "Đã bán ${product.sold}",
//         style: TextStyle(
//           fontSize: 9,
//         ),
//       );
// }

// class DataProductsCategories extends StatelessWidget {
//   final int categoriesId;
//   final String name;
//   const DataProductsCategories(
//       {Key? key, required this.categoriesId, required this.name})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getProductsBTCategories(http.Client(), categoriesId),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             print(snapshot.error);
//           }
//           return snapshot.hasData
//               ? FlashSale(
//                   products: snapshot.data as List<Product>,
//                   nameCategories: this.name)
//               : Center(
//                   child: CircularProgressIndicator(
//                     color: kPrimaryColor,
//                   ),
//                 );
//         });
//   }
// }
