import 'package:flutter/material.dart';

class CategoriesPlant {
  late int id;
  late String name;
  late int color;
  late String image;

  CategoriesPlant(
      {required this.id,
      required this.name,
      required this.color,
      required this.image});

  //sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'image': image,
    };
  }

  CategoriesPlant.fromValues(var json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    image = json['image'];
  }
}

List<CategoriesPlant> fakeCategoriesPlant = [
  CategoriesPlant(
      id: 1, name: "Táo", color: 0xFFE6BFB8, image: "assets/images/apple.png"),
  CategoriesPlant(
      id: 2,
      name: "Việt quất",
      color: 0xFF99FFFF,
      image: "assets/images/blueberries.png"),
  CategoriesPlant(
      id: 3,
      name: "Anh đào",
      color: 0xFFE6BFB8,
      image: "assets/images/cherry.png"),
  CategoriesPlant(
      id: 4, name: "Ngô", color: 0xFFFFE49D, image: "assets/images/corn.png"),
  CategoriesPlant(
      id: 5, name: "Nho", color: 0xFFC8C9E8, image: "assets/images/grape.png"),
  CategoriesPlant(
      id: 6, name: "Cam", color: 0xFFFF8C00, image: "assets/images/orange.png"),
  CategoriesPlant(
      id: 7, name: "Đào", color: 0xFFF08080, image: "assets/images/peach.png"),
  CategoriesPlant(
      id: 8,
      name: "Ớt chuông",
      color: 0xFFF5C2BF,
      image: "assets/images/chili_pepper.png"),
  CategoriesPlant(
      id: 9,
      name: "Khoai tây",
      color: 0xFFE8DDC1,
      image: "assets/images/potato.png"),
//   CategoriesPlant(
//       id: 10,
//       name: "Mâm xôi",
//       color: Color(0xFFFF0000),
//       image: "assets/images/raspberry.png"),
//   CategoriesPlant(
//       id: 11,
//       name: "Đậu tương",
//       color: Color(0xFFD4D9C5),
//       image: "assets/images/soybean.png"),
//   CategoriesPlant(
//       id: 12,
//       name: "Bí",
//       color: Color(0xFFFF7F00),
//       image: "assets/images/butternut_squash.png"),
//   CategoriesPlant(
//       id: 13,
//       name: "Dâu tây",
//       color: Color(0xFFFFC0CB),
//       image: "assets/images/strawberry.png"),
//   CategoriesPlant(
//       id: 14,
//       name: "Cà chua",
//       color: Color(0xFFFF0000),
//       image: "assets/images/tomato.png"),
];
