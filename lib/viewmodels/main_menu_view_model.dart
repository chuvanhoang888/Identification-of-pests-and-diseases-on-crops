import 'package:project_detect_disease_datn/model/main_menu_model.dart';

class MainMenuViewModel {
  List<MainMenuModel> getMainMenu() {
    return [
      MainMenuModel(
          image: "assets/images/icon_lightning.png",
          title: "Khung giờ săn sale"),
      MainMenuModel(
          image: "assets/images/icon_hangquocte.png", title: "Hàng quốc tế"),
      MainMenuModel(
          image: "assets/images/icon_shopping-cart.png", title: "Siêu thị"),
      MainMenuModel(
          image: "assets/images/icon_voucher.png", title: "Mã giảm giá"),
      MainMenuModel(
          image: "assets/images/icon_free-delivery.png", title: "FreeShip"),
      MainMenuModel(
          image: "assets/images/icon_napthe.png", title: "Nạp thẻ & Dịch vụ"),
    ];
  }
}
