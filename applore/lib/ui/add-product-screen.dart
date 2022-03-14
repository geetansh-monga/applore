import 'package:applore/firebase/cloud_firestore.dart';
import 'package:applore/model/product-model.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ProductModel _productModel = ProductModel();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: "Product Name"),
                        validator: (value) {
                          if (value == null || value == "") {
                            return "required";
                          }
                          return null;
                        },
                        onChanged: (value) => _productModel.productName = value,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Product Description"),
                        validator: (value) {
                          if (value == null || value == "") {
                            return "required";
                          }
                          return null;
                        },
                        onChanged: (value) => _productModel.description = value,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(hintText: "Price"),
                        validator: (value) {
                          if (value == null || value == "") {
                            return "required";
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            _productModel.productPrice = int.parse(value),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _productModel.createdAt = DateTime.now();
                              await cloudFirestore
                                  .addProduct(_productModel)
                                  .whenComplete(() {
                                print("product added");
                                Navigator.pop(context, true);
                              }).onError((error, stackTrace) => print(error));
                            }
                          },
                          child: const Text("Add Product"))
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
