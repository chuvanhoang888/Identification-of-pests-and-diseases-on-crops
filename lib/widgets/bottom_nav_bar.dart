// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:e_commerce_shopee/constants.dart';
// import 'package:e_commerce_shopee/screens/home/home_page.dart';

// import '../enums.dart';

// class BottomNavBar extends StatelessWidget {
//   const BottomNavBar({
//     Key? key,
//     @required this.selectedMenu,
//   }) : super(key: key);
//   final MenuState? selectedMenu;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       height: 80,
//       color: Colors.white,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//             onTap: () => Navigator.pushNamed(context, HomePage.routeName),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 SvgPicture.asset("assets/icons/calendar.svg",
//                     color: MenuState.home == selectedMenu
//                         ? kBlueLightColor_2
//                         : kTextColor),
//                 Text(
//                   "Home",
//                   style: TextStyle(
//                       color: MenuState.home == selectedMenu
//                           ? kBlueLightColor_2
//                           : kTextColor),
//                 )
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: () => Navigator.pushNamed(context, HomePage.routeName),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 SvgPicture.asset("assets/icons/gym.svg",
//                     color: MenuState.detection == selectedMenu
//                         ? kBlueLightColor_2
//                         : kTextColor),
//                 Text(
//                   "Detection",
//                   style: TextStyle(
//                       color: MenuState.detection == selectedMenu
//                           ? kBlueLightColor_2
//                           : kTextColor),
//                 )
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: () => Navigator.pushNamed(context, HomePage.routeName),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 SvgPicture.asset("assets/icons/Settings.svg",
//                     color: MenuState.profile == selectedMenu
//                         ? kBlueLightColor_2
//                         : kTextColor),
//                 Text(
//                   "Settings",
//                   style: TextStyle(
//                       color: MenuState.profile == selectedMenu
//                           ? kBlueLightColor_2
//                           : kTextColor),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
