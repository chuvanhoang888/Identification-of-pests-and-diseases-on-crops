// import 'package:e_commerce_shopee/constants.dart';
// import 'package:e_commerce_shopee/model/product_model.dart';
// import 'package:e_commerce_shopee/screens/detail/detail_page.dart';
// import 'package:e_commerce_shopee/utils/format.dart';
// import 'package:e_commerce_shopee/viewmodels/product_view_model.dart';
// import 'package:e_commerce_shopee/widgets/discount_painter.dart';
// import 'package:flutter/material.dart';

// class TogetherMoreProduct extends StatelessWidget {
//   final List<ProductModel> _productViewModel = ProductViewModel().getProduct();

//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.grey[200],
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           _buildHeader(),
//           _buildProductList(),
//         ],
//       ),
//     );
//   }

//   Container _buildHeader() => Container(
//         color: Colors.white,
//         padding: const EdgeInsets.all(12),
//         child: Text(
//           "Có thể bạn cũng thích",
//           style: TextStyle(
//               //color: Colors.deepOrange,
//               color: kPrimaryColor,
//               fontWeight: FontWeight.w600,
//               fontSize: 16),
//         ),
//       );

//   Column _buildProductList() => Column(
//         children: [
//           GridView.builder(
//             padding: EdgeInsets.all(6),
//             shrinkWrap:
//                 true, //Hàm tạo này thích hợp cho các khung nhìn lưới có số lượng lớn (hoặc vô hạn) con vì trình tạo chỉ được gọi cho những con thực sự hiển thị, có cái này ko phải khai báo height cho gridview khi bọc nó bằng column()
//             physics:
//                 NeverScrollableScrollPhysics(), //Tạo vật lý cuộn không cho phép người dùng cuộn(Nghiã là nó sẽ dài xuống vô hạn)
//             itemCount: _productViewModel.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               childAspectRatio: 0.75,
//               crossAxisCount: 2,
//               mainAxisSpacing: 6, // khoangr cách trục đứng
//               crossAxisSpacing:
//                   6, // Khoảng cách trục chéo (tức trục ngang nếu listview xổ từ trên xuống)
//             ),
//             itemBuilder: (BuildContext context, int index) {
//               return ProductItemCard(_productViewModel[index]);
//             },
//           ),
//           false ? SizedBox(height: 150) : BottomLoader(),
//         ],
//       );
// }

// class ProductItemCard extends StatelessWidget {
//   final ProductModel product;

//   const ProductItemCard(this.product);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => Navigator.push(
//           context, MaterialPageRoute(builder: (context) => DetailPage())),
//       child: LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//           return Container(
//             color: Colors.white,
//             child: Column(
//               children: [
//                 _buildProductImage(constraints.maxHeight),
//                 // Text(constraints.maxHeight.toString() +
//                 //     "\n" +
//                 //     constraints.maxWidth.toString() +
//                 //     "\n" +
//                 //     constraints.minHeight.toString() +
//                 //     "\n" +
//                 //     constraints.minWidth.toString()),
//                 _buildProductInfo(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Stack _buildProductImage(double maxHeight) {
//     return Stack(
//       children: <Widget>[
//         Image.network(
//           "${product.image}",
//           height: maxHeight - 90,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         ),
//         if (product.discountPercentage != 0) _buildDiscount(),
//         if (product.mall) _buildMall(),
//         if (product.shopRecommended) _buildShopRecommended(),
//       ],
//     );
//   }

//   Positioned _buildDiscount() => Positioned(
//         right: 0,
//         child: Container(
//           height: 50,
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
//                   "GIẢM",
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

//   Container _buildMall() => Container(
//         padding: EdgeInsets.all(2),
//         decoration: BoxDecoration(
//           color: Color(0xffd0011b),
//           borderRadius: BorderRadius.circular(2),
//         ),
//         child: Text(
//           "Mall",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 13,
//           ),
//         ),
//       );

//   Container _buildShopRecommended() => Container(
//         padding: EdgeInsets.all(2),
//         decoration: BoxDecoration(
//           color: Colors.deepOrange,
//           borderRadius: BorderRadius.circular(2),
//         ),
//         child: Text(
//           "Yêu thích",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 10,
//           ),
//         ),
//       );

//   Padding _buildProductInfo() => Padding(
//         padding: EdgeInsets.all(8),
//         child: Column(
//           children: [
//             _buildName(),
//             SizedBox(height: 12),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildPrice(),
//                 _buildSold(),
//               ],
//             ),
//           ],
//         ),
//       );

//   Text _buildName() => Text(
//         '${product.name}',
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//       );

//   RichText _buildPrice() => RichText(
//         text: TextSpan(
//           text: '\đ',
//           style: TextStyle(
//             color: Colors.deepOrange,
//             fontSize: 12,
//           ),
//           children: <TextSpan>[
//             TextSpan(
//               text: '${Format().currency(product.price, decimal: false)}',
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       );

//   Text _buildSold() => Text(
//         "Đã bán ${product.sold}",
//         style: TextStyle(
//           fontSize: 10,
//         ),
//       );
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
