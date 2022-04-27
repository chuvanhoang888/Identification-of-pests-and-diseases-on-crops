class Product {
  late int id;
  late String name;
  late String description;
  late int priceCost;
  late int price;
  late int priceSale;
  late int discountPercentage;
  late int quantity;
  late int sold;
  late int categoryDetailId;
  late List<Images> images;
  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.priceCost,
      required this.price,
      required this.priceSale,
      required this.discountPercentage,
      required this.quantity,
      required this.sold,
      required this.categoryDetailId,
      required this.images});
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    priceCost = json['price_cost'];
    price = json['price'];
    priceSale = json['price_sale'];
    discountPercentage = json['discount_percentage'];
    quantity = json['quantity'];
    sold = json['sold'];
    categoryDetailId = json['category_detail_id'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }
}

class Images {
  late int id;
  late String src;
  late int productId;

  Images({required this.id, required this.src, required this.productId});

  Images.fromJson(Map<String, dynamic> json) {
    src = json['link'];
  }
}
