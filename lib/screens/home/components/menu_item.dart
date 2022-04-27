import 'package:flutter/material.dart';
import 'package:project_detect_disease_datn/model/menu_item.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemSettings,
    itemAssess,
    itemProposing,
    itemcontact,
    itemThanks,
    itemNotification,
    itemInstruct
  ];
  static const itemSettings = MenuItem(text: "Cài đặt");
  static const itemAssess = MenuItem(text: "Đánh giá Agdis");
  static const itemProposing = MenuItem(text: "Đề xuất Agdis");
  static const itemcontact = MenuItem(text: "Liên hệ & trao đổi");
  static const itemThanks = MenuItem(text: "Cảm ơn");
  static const itemNotification = MenuItem(text: "Thông báo pháp lý");
  static const itemInstruct = MenuItem(text: "Hướng dẫn nhanh");
}
