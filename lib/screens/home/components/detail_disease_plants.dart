import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailDiseasePlant extends StatefulWidget {
  final String title;
  final String content;
  DetailDiseasePlant({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  _DetailDiseasePlantState createState() => _DetailDiseasePlantState();
}

class _DetailDiseasePlantState extends State<DetailDiseasePlant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Text(
            this.widget.title,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
            child: Html(
          data: this.widget.content,
        )));
  }
}
