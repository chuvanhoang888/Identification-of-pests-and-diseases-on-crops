// import 'dart:convert';
// import 'dart:io';
// import 'package:project_detect_disease_datn/apiServices/global.dart';
// import 'package:project_detect_disease_datn/model/banner.dart';
// import 'package:project_detect_disease_datn/model/category_menu_model.dart';
// import 'package:project_detect_disease_datn/model/customer.dart';
// import 'package:project_detect_disease_datn/model/login_model.dart';
// import 'package:project_detect_disease_datn/model/product.dart';
// import 'package:http/http.dart' as http;

// Future<List<Product>> getProducts(http.Client client) async {
//   final response = await client.get(Uri.parse(URL_RANDOM_PRODUCTS));
//   if (response.statusCode == 200) {
//     Map<String, dynamic> mapResponse = json.decode(response.body);
//     if (mapResponse["result"] == "ok") {
//       final products = mapResponse["data"].cast<Map<String, dynamic>>();
//       final listOfProducts = await products.map<Product>((json) {
//         return Product.fromJson(json);
//       }).toList();
//       return listOfProducts;
//     } else {
//       return [];
//     }
//   } else {
//     throw Exception('Failed to load product from the Internet');
//   }
// }

// //////////////////////////////////////////////////////////////////////////////
// Future<List<CategoryMenuModel>> getCategories(http.Client client) async {
//   final response = await client.get(Uri.parse(URL_CATEGORIES));
//   if (response.statusCode == 200) {
//     Map<String, dynamic> mapResponse = json.decode(response.body);
//     if (mapResponse["result"] == "ok") {
//       final categories = mapResponse["data"].cast<Map<String, dynamic>>();
//       final listOfCategories = await categories.map<CategoryMenuModel>((json) {
//         return CategoryMenuModel.fromJson(json);
//       }).toList();
//       return listOfCategories;
//     } else {
//       return [];
//     }
//   } else {
//     throw Exception('Failed to load categories from the Internet');
//   }
// }

// //////////////////////////////////////////////////////////////////////////////
// Future<List<Banners>> getBanners(http.Client client) async {
//   final response = await client.get(Uri.parse(URL_BANNER));
//   if (response.statusCode == 200) {
//     Map<String, dynamic> mapResponse = json.decode(response.body);
//     if (mapResponse["result"] == "ok") {
//       final banners = mapResponse["data"].cast<Map<String, dynamic>>();
//       final listOfBanners = await banners.map<Banners>((json) {
//         return Banners.fromJson(json);
//       }).toList();
//       return listOfBanners;
//     } else {
//       return [];
//     }
//   } else {
//     throw Exception('Failed to load banners from the Internet');
//   }
// }

// //////////////////////////////////////////////////////////////////////////////
// Future<List<Product>> getProductsBTCategories(
//     http.Client client, int categoriesId) async {
//   final response = await client
//       .get(Uri.parse("$URL_PRODUCTS_BELONGSTO_CATEGORIES$categoriesId"));
//   if (response.statusCode == 200) {
//     Map<String, dynamic> mapResponse = json.decode(response.body);
//     if (mapResponse["result"] == "ok") {
//       final products = mapResponse["data"].cast<Map<String, dynamic>>();
//       final listProducts = await products.map<Product>((json) {
//         return Product.fromJson(json);
//       }).toList();
//       return listProducts;
//     } else {
//       return [];
//     }
//   } else {
//     throw Exception(
//         'Failed to load products belongTo Cateories from the Internet');
//   }
// }

// ///////////////////////////////////////////////////
// class APIService {
//   Future<bool> createCustomer(http.Client client, CustomerModel model) async {
//     // var authToken = base64.encode(utf8.encode(Config.key + ":" + Config.sceret));
//     bool ret = true;

//     try {
//       final response = await client.post(
//         Uri.parse(Config.url + Config.customerURL),
//         body: model.toJson(),
//         // headers: {
//         //   HttpHeaders.authorizationHeader: 'Basic $authToken',
//         //   HttpHeaders.contentTypeHeader: "application/json"
//         // });
//       );
//       print(model.toJson());
//       if (response.statusCode == 201) {
//         Map<String, dynamic> mapResponse = json.decode(response.body);
//         print(mapResponse);
//         if (mapResponse["result"] == "ok") {
//           ret = true;
//         } else {
//           ret = false;
//         }
//       } else {
//         ret = false;
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//     print(ret);
//     return ret;
//   }

//   Future<LoginResponseModel> loginCustomer(
//       http.Client client, String username, String password) async {
//     LoginResponseModel model = LoginResponseModel();
//     print(username + password);

//     try {
//       final response = await client
//           .post(Uri.parse(Config.url + Config.signInURL), body: {
//         "email": username,
//         "password": password
//       }, headers: {
//         HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
//       });

//       if (response.statusCode == 200) {
//         Map<String, dynamic> mapResponse = json.decode(response.body);

//         if (mapResponse["result"] == "ok") {
//           //final products = mapResponse["data"].cast<Map<String, dynamic>>();
//           //final listProducts = await products.map<Product>((json) {
//           //return model.fromJson(json);
//           //}).toList();
//           //return listProducts;
//           model = LoginResponseModel.fromJson(mapResponse["data"]);
//           print(model.toJson());
//         } else {}
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//     return model;
//   }

//   //////////////////////////////////////////////////////////////////////////////
//   Future<List<Product>> getProductsSearch(
//       http.Client client, String searchText) async {
//     final response =
//         await client.get(Uri.parse(Config.url + Config.search + "$searchText"));
//     if (response.statusCode == 200) {
//       Map<String, dynamic> mapResponse = json.decode(response.body);
//       if (mapResponse["result"] == "ok") {
//         final products = mapResponse["data"].cast<Map<String, dynamic>>();
//         final listProducts = await products.map<Product>((json) {
//           return Product.fromJson(json);
//         }).toList();
//         return listProducts;
//       } else {
//         return [];
//       }
//     } else {
//       throw Exception(
//           'Failed to load products belongTo Search from the Internet');
//     }
//   }
// }
