import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = "/notification";
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3.0,
        titleSpacing: 0,
        title: Text(
          "Thông báo",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Center(
        child: Container(
          height: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 200,
                  height: 250,
                  child: Image.asset("assets/images/watering_can.png")),
              SizedBox(
                height: 10,
              ),
              Text(
                "Không tìm thấy gì để hiển thị ở đây",
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
