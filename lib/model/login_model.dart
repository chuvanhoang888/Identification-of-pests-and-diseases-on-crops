class LoginResponseModel {
  int? id;
  String? token;
  String? name;
  String? email;
  int? phone;
  String? image;
  String? address;
  LoginResponseModel(
      {this.id,
      this.token,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.address});
  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['user_token'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    address = json['address'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['token'] = this.token;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['address'] = this.address;
    return data;
  }
}
