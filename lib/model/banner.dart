class Banners {
  late int id;
  late String image;

  Banners({required this.id, required this.image});

  // factory Banner.fromJson(Map<String, dynamic> json) {
  //   return Banner(id: json['id'], image: json['image']);
  // }

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
