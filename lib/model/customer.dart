class CustomerModel {
  String? name;
  String? email;
  String? phone;
  String? password;

  CustomerModel({this.name, this.email, this.phone, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map.addAll(
        {'name': name, 'email': email, 'phone': phone, 'password': password});

    return map;
  }
}
