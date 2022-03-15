import 'package:applore/firebase/cloud_firestore.dart';
import 'package:applore/model/product-model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
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
                        keyboardType: TextInputType.number,
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
                              _productModel.createdAt = Timestamp.now();
                              await cloudFirestore
                                  .addProduct(_productModel)
                                  .onError((error, stackTrace) => print(error));
                              print("product added");
                              Navigator.pop(context, true);
                            }
                          },
                          child: const Text(
                            "Add Product",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
