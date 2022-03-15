import 'package:applore/model/product-model.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({Key? key, required ProductModel product})
      : _product = product,
        super(key: key);
  final ProductModel _product;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 22, 164, 230),
          blurRadius: 0.5,
          spreadRadius: 0.5,
          offset: Offset.fromDirection(1, 5),
        ),
        BoxShadow(
          color: Color.fromARGB(255, 145, 206, 235),
          blurRadius: 0.5,
          spreadRadius: 0.5,
          offset: Offset.fromDirection(1, 5),
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 23),
        horizontalTitleGap: 10,
        leading: const FlutterLogo(
          size: 100,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${_product.productName.toString()}"),
            const SizedBox(
              height: 10,
            ),
            Text("Description: ${_product.description.toString()}"),
            const SizedBox(
              height: 10,
            ),
            Text("Price: ${_product.productPrice.toString()}"),
          ],
        ),
      ),
    );
  }
}
