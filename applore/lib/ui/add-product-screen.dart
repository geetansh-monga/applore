import 'dart:io';
import 'package:applore/firebase/cloud_firestore.dart';
import 'package:applore/model/product-model.dart';
import 'package:applore/ui/widgets/add_product_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ProductModel _productModel = ProductModel();
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AddproductImage(
                        onProductImageAdded: (imageFile) async {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Orignal Image size: ${(imageFile!.readAsBytesSync().lengthInBytes / (1024 * 1024)).toStringAsFixed(2)} MB")));
                          File? _compressedImageFile =
                              await FlutterImageCompress.compressAndGetFile(
                            imageFile.absolute.path,
                            imageFile.path,
                            quality: 75,
                          );
                          _imageFile = _compressedImageFile;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Compressed Image size: ${(_compressedImageFile!.readAsBytesSync().lengthInBytes / (1024 * 1024)).toStringAsFixed(2)} MB")));
                        },
                      ),
                      const SizedBox(
                        height: 60,
                      ),
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
                              if (_imageFile != null) {
                                _productModel.createdAt = Timestamp.now();
                                UploadTask _uploadTask = FirebaseStorage
                                    .instance
                                    .ref(
                                        "${FirebaseAuth.instance.currentUser!.email}/products/${DateTime.now()}}")
                                    .putFile(_imageFile!);
                                final snapshot =
                                    await _uploadTask.whenComplete(() => null);
                                final String url =
                                    await snapshot.ref.getDownloadURL();
                                print("image url:" + url.toString());
                                _productModel.productImageUrl = url.toString();
                                await cloudFirestore
                                    .addProduct(_productModel)
                                    .onError(
                                        (error, stackTrace) => print(error));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "${_productModel.productName} added to Firestore")));
                                Navigator.pop(context, true);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Product Image not added")));
                              }
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
        ),
      ),
    );
  }
}
