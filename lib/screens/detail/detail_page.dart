import 'package:project_detect_disease_datn/model/product.dart';

import 'package:project_detect_disease_datn/screens/detail/components/content.dart';

import 'package:flutter/material.dart';
import 'package:project_detect_disease_datn/screens/detail/components/header.dart';

class DetailPage extends StatefulWidget {
  static String routeName = "/detail_page";
  final Product productModel;
  const DetailPage({required this.productModel});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _scrollController = TrackingScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Stack(
        children: [
          Content(
            scrollController: _scrollController,
            product: this.widget.productModel,
          ),
          Header(_scrollController),
        ],
      ),
    );
  }
}
