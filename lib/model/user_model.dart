class UserModel {
  String? uid;
  String? email;
  String? name;
  String? phone;
  String? imageUrl;

  UserModel({
    this.uid,
    this.email,
    this.name,
    this.phone,
    this.imageUrl,
  });
  //receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        phone: map['phone'],
        imageUrl: map['imageUrl']);
  }
  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'imageUrl': imageUrl
    };
  }
}
