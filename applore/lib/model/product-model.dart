import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? productName;
  String? description;
  String? productImageUrl;
  int? productPrice;
  var createdAt; //Date and Time

  ProductModel({this.productName, this.description, this.productPrice});

  Map<String, dynamic> toMap(ProductModel product) {
    var data = Map<String, dynamic>();
    data["productName"] = product.productName;
    data["description"] = product.description;
    data["productImageUrl"] = product.productImageUrl;
    data["productPrice"] = product.productPrice;
    data["createdAt"] = product.createdAt;
    return data;
  }

  ProductModel.fromMap(DocumentSnapshot mapData) {
    this.createdAt = mapData["createdAt"];
    this.productName = mapData["productName"];
    this.description = mapData["description"];
    this.productImageUrl = mapData["productImageUrl"];
    this.productPrice = mapData["productPrice"];
  }
}
