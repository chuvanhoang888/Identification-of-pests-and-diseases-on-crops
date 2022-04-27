class ProductModel {
  final bool shopRecommended;
  final bool mall;
  final int discountPercentage;
  final String? image;
  final String? name;
  final double price;
  final int sold;

  ProductModel({
    this.shopRecommended = false,
    this.mall = false,
    this.price = 0.0,
    this.discountPercentage = 0,
    this.name,
    this.image,
    this.sold = 0,
  });
}
