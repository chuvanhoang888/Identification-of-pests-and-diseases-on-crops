import 'package:project_detect_disease_datn/components/camera_screen.dart';
import 'package:project_detect_disease_datn/data/upload_categories.dart';
import 'package:project_detect_disease_datn/data/upload_data_disease_plants.dart';
import 'package:project_detect_disease_datn/screens/account/account_screen.dart';
import 'package:project_detect_disease_datn/screens/account/profile_account/profile_account.dart';
import 'package:project_detect_disease_datn/screens/communication/communication_screen.dart';
import 'package:project_detect_disease_datn/screens/communication/components/notification_screen.dart';
import 'package:project_detect_disease_datn/screens/communication/components/upload_post.dart';
import 'package:project_detect_disease_datn/screens/complete_profile/complete_profile_screen.dart';
import 'package:project_detect_disease_datn/screens/home/components/list_history.dart';
import 'package:project_detect_disease_datn/screens/home/components/weather_detail.dart';
import 'package:project_detect_disease_datn/screens/home/home_page.dart';
import 'package:project_detect_disease_datn/screens/page_view/page_view.dart';
import 'package:project_detect_disease_datn/screens/search/search_screen.dart';
import 'package:project_detect_disease_datn/screens/sign_in/sign_in_screen.dart';
import 'package:project_detect_disease_datn/screens/sign_up/sign_up_screen.dart';
import 'package:project_detect_disease_datn/screens/splash/splash_screen.dart';
import 'package:project_detect_disease_datn/widgets/countdown.dart';
import 'package:flutter/widgets.dart';

//Chúng ta sử dụng tên route - we use name route
//tất cả các tuyến đường của chúng tôi sẽ có sẵn ở đây - all our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignUpscreen.routeName: (context) => SignUpscreen(),
  HomePage.routeName: (context) => HomePage(),
  CountDown.routeName: (context) => CountDown(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  //SearchListScreen.routeName: (context) => SearchListScreen(
  //   search: '',
  // ),
  SplashScreen.routeName: (context) => SplashScreen(),
  AccountScreen.routeName: (context) => AccountScreen(),
  CameraScreen.routeName: (context) => CameraScreen(),
  //DetailPage.routeName: (context) => DetailPage(),
  CommunicationScreen.routeName: (context) => CommunicationScreen(),
  UploadPost.routeName: (context) => UploadPost(),
  ProfileAccount.routeName: (context) => ProfileAccount(),
  //DetailPosts.routeName: (context) => DetailPosts(post: null,),
  PagesView.routeName: (context) => PagesView(),
  WeatherDetail.routeName: (context) => WeatherDetail(),
  UploadData.routeName: (context) => UploadData(),
  UploadCategories.routeName: (context) => UploadCategories(),
  HistoryList.routeName: (context) => HistoryList(),
  NotificationScreen.routeName: (context) => NotificationScreen()
};
