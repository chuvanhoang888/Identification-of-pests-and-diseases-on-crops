import 'dart:async';

import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  static String routeName = "/count_down";
  const CountDown({Key? key}) : super(key: key);

  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  static const countdownDuration = Duration(hours: 2);
  Duration duration = Duration();
  Timer? timer;
  @override
  void initState() {
    startTimer();
    duration = countdownDuration;
    super.initState();
  }

  void addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds - addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    return buildTime();
  }

  Widget buildTime() {
    //9 --> 09, 11 --> 11
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      children: [
        buildTimeCard(time: hours),
        Text(":"),
        buildTimeCard(time: minutes),
        Text(":"),
        buildTimeCard(time: seconds),
      ],
    );
  }

  Widget buildTimeCard({required String time}) => Container(
        width: 25,
        height: 25,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black, //Color(0xFFFC8DB7),
          ),
        ),
      );
}
