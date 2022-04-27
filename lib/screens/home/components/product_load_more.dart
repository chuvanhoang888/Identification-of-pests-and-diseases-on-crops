// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:project_detect_disease_datn/apiServices/api.dart';
// import 'package:project_detect_disease_datn/constants.dart';
// import 'package:project_detect_disease_datn/screens/detail/detail_page.dart';
// import 'package:project_detect_disease_datn/utils/format.dart';
// import 'package:project_detect_disease_datn/widgets/discount_painter.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:project_detect_disease_datn/model/product.dart';
// import 'package:intl/intl.dart';

// class ProductList extends StatelessWidget {
//   final List<Product> products;
//   ProductList({required this.products});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GridView.builder(
//           padding: EdgeInsets.all(6),
//           shrinkWrap:
//               true, //Hàm tạo này thích hợp cho các khung nhìn lưới có số lượng lớn (hoặc vô hạn) con vì trình tạo chỉ được gọi cho những con thực sự hiển thị, có cái này ko phải khai báo height cho gridview khi bọc nó bằng column()
//           physics:
//               NeverScrollableScrollPhysics(), //Tạo vật lý cuộn không cho phép người dùng cuộn(Nghiã là nó sẽ dài xuống vô hạn)
//           itemCount: products.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             childAspectRatio: 2 / 3, //width/height cua the ProductItemCard
//             crossAxisCount: 2,
//             mainAxisSpacing: 10, // khoangr cách trục đứng
//             crossAxisSpacing:
//                 10, // Khoảng cách trục chéo (tức trục ngang nếu listview xổ từ trên xuống)
//           ),
//           itemBuilder: (BuildContext context, int index) {
//             //var data = products[index];
//             return InkWell(
//               onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           DetailPage(productModel: products[index]))),
//               // onTap: () => Navigator.pushNamed(context, DetailPage.routeName,
//               //     arguments: {productModel:this.products[index]}),
//               child: LayoutBuilder(
//                 builder: (BuildContext context, BoxConstraints constraints) {
//                   return Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(width: 0.5, color: Colors.black12),
//                         borderRadius: BorderRadius.circular(5)),
//                     child: Column(
//                       children: [
//                         buildProductImage(index, constraints),
//                         // Text(constraints.maxHeight.toString() +
//                         //     "\n" +
//                         //     constraints.maxWidth.toString() +
//                         //     "\n" +
//                         //     constraints.minHeight.toString() +
//                         //     "\n" +
//                         //     constraints.minWidth.toString()),
//                         Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Column(
//                             children: [
//                               buildName(index),
//                               SizedBox(height: 12),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   buildPrice(index),
//                                   buildSold(index),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             );
//           },
//         ),
//         false ? SizedBox(height: 150) : BottomLoader(),
//       ],
//     );
//   }

//   Stack buildProductImage(int index, BoxConstraints constraints) {
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
//             imageUrl: "${products[index].images[0].src}",
//             height: constraints.maxHeight - 90,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//         ),
//         if (products[index].discountPercentage != 0) _buildDiscount(index),
//       ],
//     );
//   }

//   Positioned _buildDiscount(int index) => Positioned(
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
//                   "${products[index].discountPercentage}%",
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
//   // Container buildMall() => Container(
//   //       padding: EdgeInsets.all(2),
//   //       decoration: BoxDecoration(
//   //         color: Color(0xffd0011b),
//   //         borderRadius: BorderRadius.circular(2),
//   //       ),
//   //       child: Text(
//   //         "Mall",
//   //         style: TextStyle(
//   //           color: Colors.white,
//   //           fontWeight: FontWeight.bold,
//   //           fontSize: 13,
//   //         ),
//   //       ),
//   //     );

//   // Container buildShopRecommended() => Container(
//   //       padding: EdgeInsets.all(2),
//   //       decoration: BoxDecoration(
//   //         color: Colors.deepOrange,
//   //         borderRadius: BorderRadius.circular(2),
//   //       ),
//   //       child: Text(
//   //         "Yêu thích",
//   //         style: TextStyle(
//   //           color: Colors.white,
//   //           fontWeight: FontWeight.bold,
//   //           fontSize: 10,
//   //         ),
//   //       ),
//   //     );

//   Text buildName(int index) => Text(
//         '${products[index].name}',
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(fontWeight: FontWeight.w500),
//       );

//   RichText buildPrice(int index) => RichText(
//         text: TextSpan(
//           text: '\đ ',
//           style: TextStyle(
//             color: Colors.deepOrange,
//             fontSize: 15,
//           ),
//           children: <TextSpan>[
//             TextSpan(
//               text:
//                   // '${Format().currency(products[index].price, decimal: false)}',
//                   '${NumberFormat.currency(locale: 'eu', decimalDigits: 0, symbol: "").format(products[index].price).toString()}',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       );

//   Text buildSold(
//     int index,
//   ) =>
//       Text(
//         "Đã bán ${products[index].sold}",
//         style: TextStyle(
//           fontSize: 10,
//         ),
//       );
// }

// class ProductLoadMore extends StatefulWidget {
//   @override
//   _ProductLoadMoreState createState() => _ProductLoadMoreState();
// }

// class _ProductLoadMoreState extends State<ProductLoadMore> {
//   //final List<ProductModel> _productViewModel = ProductViewModel().getProduct();

//   Widget build(BuildContext context) {
//     return Container(
//       //color: Colors.grey[200],
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           buildHeader(),
//           buildProductList(),
//         ],
//       ),
//     );
//   }

//   Container buildHeader() => Container(
//         color: Colors.white,
//         padding: const EdgeInsets.all(12),
//         child: Text(
//           "GỢI Ý HÔM NAY",
//           style: TextStyle(
//               //color: Colors.deepOrange,
//               color: kPrimaryColor,
//               fontWeight: FontWeight.w600,
//               fontSize: 16),
//         ),
//       );

//   Widget buildProductList() {
//     return FutureBuilder(
//         future: getProducts(http.Client()),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             print(snapshot.error);
//           }
//           return snapshot.hasData
//               ? ProductList(
//                   products: snapshot.data as List<Product>,
//                 )
//               : Center(
//                   child: CircularProgressIndicator(
//                     color: kPrimaryColor,
//                   ),
//                 );
//         });
//   }
// }

// class BottomLoader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 12, bottom: 22),
//       width: double.infinity,
//       alignment: Alignment.center,
//       child: Center(
//         child: Text(
//           "Không còn sản phẩm",
//           style: TextStyle(
//             color: Colors.deepOrange,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }
