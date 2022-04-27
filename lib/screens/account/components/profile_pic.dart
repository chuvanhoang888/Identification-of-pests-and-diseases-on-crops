// import 'package:project_detect_disease_datn/apiServices/global.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:project_detect_disease_datn/constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// String? finalImage;
// String? finalName;

// class ProfilePic extends StatefulWidget {
//   const ProfilePic({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _ProfilePicState createState() => _ProfilePicState();
// }

// class _ProfilePicState extends State<ProfilePic> {
//   @override
//   void initState() {
//     getValidationData();

//     super.initState();
//   }

//   Future getValidationData() async {
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     var image = sharedPreferences.getString('user_image');
//     var name = sharedPreferences.getString('user_name');
//     setState(() {
//       finalImage = image;
//       finalName = name;
//     });
//     print(finalImage);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Column(
//           children: [
//             SizedBox(
//               height: 50,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   border: Border.all(color: Color(0xFFF5F6F9), width: 3),
//                   shape: BoxShape.circle),
//               child: SizedBox(
//                 height: 115,
//                 width: 115,
//                 child: Stack(
//                   fit: StackFit.expand,
//                   clipBehavior: Clip.none,
//                   //Thêm cái này để nó ko ăn thằng FlatButton Camera
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(70),
//                       child: finalImage == null
//                           ? Image.asset(
//                               "assets/images/image_processing20210907-13511-1juj33d.gif")
//                           : Image.network("http://$SERVER_NAME/$finalImage"),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: -10,
//                       child: SizedBox(
//                         height: 46,
//                         width: 46,
//                         child: TextButton(
//                           style: TextButton.styleFrom(
//                             primary: Colors.white,
//                             side: BorderSide(color: Colors.white),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             padding: EdgeInsets.zero,
//                             backgroundColor: Color(0xFFF5F6F9),
//                           ),
//                           //color: Color(0xFFF5F6F9),
//                           onPressed: () {},
//                           child:
//                               SvgPicture.asset("assets/icons/Camera Icon.svg"),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               "$finalName",
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: Colors.black),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }
