class ProductModel {
  String? productName;
  String? description;
  String? productImageUrl;
  int? productPrice;

  ProductModel({this.productName, this.description, this.productPrice});

  Map<String, dynamic> toMap(ProductModel product) {
    var data = Map<String, dynamic>();
    data["productName"] = product.productName;
    data["description"] = product.description;
    data["productImageUrl"] = product.productImageUrl;
    data["productPrice"] = product.productPrice;
    return data;
  }

  ProductModel.fromMap(Map<String, dynamic> mapData) {
    this.productName = mapData["productName"];
    this.description = mapData["description"];
    this.productImageUrl = mapData["productImageUrl"];
    this.productPrice = mapData["productPrice"];
  }
}
