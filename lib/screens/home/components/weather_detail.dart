import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_detect_disease_datn/components/default_button.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/model/menu_item.dart';
import 'package:project_detect_disease_datn/screens/home/components/menu_item.dart';
import 'package:project_detect_disease_datn/screens/splash/splash_screen.dart';
import 'package:project_detect_disease_datn/size_config.dart';
import 'package:http/http.dart' as http;

class WeatherDetail extends StatefulWidget {
  static String routeName = "/weather_detail";
  const WeatherDetail({Key? key}) : super(key: key);

  @override
  _WeatherDetailState createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  double? temperature;
  String location = "Ho Chi Minh City";
  String weather = "clear";
  int woeid = 1252431;
  String abbrevation = "";
  String errorMessage = "";
  int? minTemp;
  int? maxTemp;
  int? humidity;
  var tempList = [];
  var weatherNameList = [];
  late Position _currentPosition;
  late String _currentAddress;
  late DateFormat dateFormat;

  Future<void> _getCurrentPosition() async {
// verify permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
// get current position
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // get address
    _getGeolocationAddress(_currentPosition);
  }

// Method to get Address from position:

  Future<String> _getGeolocationAddress(Position position) async {
    // geocoding
    try {
      var places = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      print(position.latitude.toString() + "|" + position.longitude.toString());

      Placemark place = places[0];
      print(place);
      setState(() {
        _currentAddress = "${place.administrativeArea}";
      });
      print(_currentAddress);
      onTextFieldSubmitted(place.administrativeArea.toString());
      //return "${place.thoroughfare}, ${place.locality}";

    } catch (e) {
      print(e);
    }
    return "No address availabe";
  }

  String searchApiUrl =
      "https://www.metaweather.com/api/location/search/?query=";
  String locationApiUrl = "https://www.metaweather.com/api/location/";
  void fetSearch(String input) async {
    //Trả về mã id của thành phố đó
    // [
    //   {
    //   title: "San Francisco",
    //   location_type: "City",
    //   woeid: 2487956,
    //   latt_long: "37.777119, -122.41964"
    //   },
    // ]
    try {
      var searchResult =
          await http.Client().get(Uri.parse(searchApiUrl + input));
      var result = jsonDecode(searchResult.body)[0];
      print("searchResult" + searchResult.body);
      print(result.toString());
      setState(() {
        location = result["title"];
        woeid = result["woeid"];
        errorMessage = "";
      });
    } catch (error) {
      setState(() {
        errorMessage =
            "Xin lỗi chúng tôi không có dữ liệu thành phố này, vui lòng thử lại";
        Fluttertoast.showToast(
            msg:
                "Xin lỗi chúng tôi không có dữ liệu thành phố này, vui lòng thử lại",
            textColor: Colors.black,
            backgroundColor: Colors.white);
      });
    }
  }

  void fetchLocation() async {
    var locationResult =
        await http.Client().get(Uri.parse(locationApiUrl + woeid.toString()));
    var result = jsonDecode(locationResult.body);
    var consolidatedWeather = result["consolidated_weather"];
    var data = consolidatedWeather[0];
    setState(() {
      // temperature = data["the_temp"].round();
      temperature = double.parse(data["the_temp"].toStringAsFixed(1));
      weather = data["weather_state_name"].replaceAll(' ', '').toLowerCase();
      abbrevation = data["weather_state_abbr"];
      minTemp = data["min_temp"].round();
      maxTemp = data["max_temp"].round();
      humidity = data["humidity"].round();
    });
  }

  void fetchLocationDay() async {
    var today = new DateTime.now();
    for (var i = 0; i < 4; i++) {
      var locationDayResult = await http.Client().get(Uri.parse(locationApiUrl +
          woeid.toString() +
          "/" +
          new DateFormat('y/M/d')
              .format(today.add(new Duration(days: i + 1)))
              .toString()));
      var result = jsonDecode(locationDayResult.body);
      var data = result[0];

      setState(() {
        tempList.add(data["the_temp"].toStringAsFixed(1));
        weatherNameList
            .add(data["weather_state_name"].replaceAll(' ', '').toLowerCase());
      });
    }
  }

  void onTextFieldSubmitted(String input) {
    fetSearch(input);
    fetchLocation();
    fetchLocationDay();
  }

  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('vi');
    fetchLocation();
    fetchLocationDay();
  }

  //  _getCurrentLocation(){
  //    geolocator.getCurr
  //  }
  _buildInputSearch() {
    final sizeicon = BoxConstraints(minWidth: 40, minHeight: 40);
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black54, width: 0),
    );
    //borderRadius: const BorderRadius.all(const Radius.circular(30.0)));
    return Row(
      children: [
        Expanded(
          child: Container(
            // decoration: BoxDecoration(boxShadow: [
            //   BoxShadow(
            //     color: Colors.black38,
            //     blurRadius: 25,
            //     offset: const Offset(0, 5), // changes position of shadow
            //   )
            // ]),
            child: TextField(
              onSubmitted: (String input) {
                onTextFieldSubmitted(input);
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  isDense: true,
                  enabledBorder: border,
                  focusedBorder: border,
                  hintText: "Dự báo thời tiết ",
                  hintStyle: TextStyle(fontSize: 15, color: Colors.black26),
                  prefixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 3.0, end: 3.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: SvgPicture.asset(
                            "assets/icons/search_2.svg",
                            color: Colors.black,
                          ),
                          width: 15,
                          height: 15,
                        ),
                      )),
                  prefixIconConstraints: sizeicon,
                  filled: true,
                  fillColor: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = new DateTime.now();
    final verticalDivider = VerticalDivider(
        color: Colors.grey[300],
        width: 2,
        indent: 1,
        endIndent: 10,
        thickness: 1);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 3,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        title: _buildInputSearch(),
        actions: [
          PopupMenuButton<MenuItem>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                    ...MenuItems.itemsFirst.map(buildItem).toList(),
                    //PopupMenuDivider(),
                    //...MenuItems.itemsFirst.map(buildItem).toList(),
                  ])
        ],
      ),
      body: temperature != null && tempList.length == 4
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    //height: getProportionateScreenHeight(200),
                    decoration: BoxDecoration(color: Color(0xFFD4DCE2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hôm nay, ${dateFormat.format(dateTime)}"),
                            Text(
                              "$temperature" + "°C",
                              style: TextStyle(fontSize: 38),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(location),
                            Text(
                              "$minTemp" + "°C" + " / " + "$maxTemp" + "°C",
                              style: TextStyle(fontSize: 13),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // Text(
                            //   "Mặt trời lặn 17:24",
                            //   style: TextStyle(fontSize: 13),
                            // )
                          ],
                        ),
                        Spacer(),
                        SizedBox(
                            width: 130,
                            child: Image.asset(
                                "assets/images/vec_weather_$weather.png"))
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text("Ít mây suốt cả ngày."),
                        Spacer(),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                                child: Image.asset(
                                    "assets/images/ic_weather_rain_propability.png"),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(5),
                              ),
                              Text(
                                "$humidity%",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("4 ngày tới"),
                        SizedBox(
                          height: 10,
                        ),
                        IntrinsicHeight(
                          child: tempList.length == 4
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    forecastElement(
                                        1, weatherNameList[0], tempList[0]),
                                    verticalDivider,
                                    forecastElement(
                                        2, weatherNameList[1], tempList[1]),
                                    verticalDivider,
                                    forecastElement(
                                        3, weatherNameList[2], tempList[2]),
                                    verticalDivider,
                                    forecastElement(
                                        4, weatherNameList[3], tempList[3]),
                                  ],
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: kPrimaryColor,
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Có thể có mưa phùn vào thứ năm tuần sau"),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Mách nhỏ",
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Thứ sáu '.toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    // '${Format().currency(products[index].price, decimal: false)}',
                                    "sẽ là một ngày thích hợp để: ",
                              ),
                              TextSpan(
                                text:
                                    // '${Format().currency(products[index].price, decimal: false)}',
                                    "Làm cỏ".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // DefaultButton(
                  //   color: Colors.black,
                  //   press: () => _getCurrentPosition(),
                  //   text: "Get location",
                  // )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
    );
  }

  Widget forecastElement(daysFromNow, weatherNameList, tempList) {
    var now = new DateTime.now();
    var oneDayFromnow = now.add(new Duration(days: daysFromNow));
    //print("now" + now.toString());
    //print("oneDayFromnow" + oneDayFromnow.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Text(new DateFormat.E().format(oneDayFromnow)),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 50,
                child: Image.asset(
                    "assets/images/vec_weather_$weatherNameList.png")),
            SizedBox(
              height: 10,
            ),
            Text(
              "$tempList" + "°C",
              style: TextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) =>
      PopupMenuItem<MenuItem>(value: item, child: Text(item.text));
  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemSettings:
        Navigator.pushNamed(context, SplashScreen.routeName);
        break;
    }
  }
}
