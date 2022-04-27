import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_detect_disease_datn/model/menu_post.dart';

class MenuPostItems {
  static const List<MenuPost> itemsFirst = [
    itemEdit,
    itemDelete,
  ];
  static const itemEdit = MenuPost(text: "Sửa", icon: Icons.edit);
  static const itemDelete = MenuPost(text: "Xóa bài viết", icon: Icons.delete);
}

class MenuPostItems2 {
  static const List<MenuPost> itemsFirst = [
    itemReport,
  ];
  static const itemReport = MenuPost(text: "Sửa", icon: Icons.report);
}
