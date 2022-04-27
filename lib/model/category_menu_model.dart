class CategoryMenuModel {
  late int id;
  late String name;
  late String image;

  CategoryMenuModel(
      {required this.id, required this.name, required this.image});

  CategoryMenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}
