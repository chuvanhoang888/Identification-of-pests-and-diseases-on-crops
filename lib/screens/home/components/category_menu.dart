// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:project_detect_disease_datn/apiServices/api.dart';
// import 'package:project_detect_disease_datn/constants.dart';
// import 'package:project_detect_disease_datn/model/category_menu_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class CategoriesList extends StatelessWidget {
//   final List<CategoryMenuModel> categories;
//   CategoriesList({Key? key, required this.categories}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 260,
//       child: GridView.builder(
//         scrollDirection: Axis.horizontal,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, childAspectRatio: 1.25, crossAxisSpacing: 10),
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {},
//             child: Column(
//               children: [
//                 Container(
//                   width: 80,
//                   height: 80,
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(color: Colors.white,
//                       //Color(0xFFEEEEEE),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.black12,
//                             offset: Offset(0, 2),
//                             blurRadius: 7.0)
//                       ]),
//                   child: CachedNetworkImage(
//                     placeholder: (context, url) => Center(
//                         child: SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(
//                               color: kPrimaryColor,
//                             ))),
//                     imageUrl: "${categories[index].image}",
//                   ),
//                   //Image.network(categories[index].image),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   categories[index].name,
//                   style: TextStyle(fontSize: 12),
//                   maxLines: 2,
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//               ],
//             ),
//           );
//         },
//         itemCount: categories.length,
//       ),
//     );
//   }
// }

// class CategoryMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Container(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "DANH MỤC",
//                     style: TextStyle(
//                         color: kPrimaryColor,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16),
//                   ),
//                   Spacer(),
//                   _buildMoreButton(),
//                 ],
//               ),
//             ),
//             BuildListCategory(),
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
// }

// class BuildListCategory extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getCategories(http.Client()),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             print(snapshot.error);
//           }
//           return snapshot.hasData
//               ? CategoriesList(
//                   categories: snapshot.data as List<CategoryMenuModel>,
//                 )
//               : Center(
//                   child: CircularProgressIndicator(
//                     color: kPrimaryColor,
//                   ),
//                 );
//         });
//   }
// }
