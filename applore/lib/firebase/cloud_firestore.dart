import 'package:applore/model/product-model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Cloud firestore for using cloud services.

class CloudFirestoreProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future addProduct(ProductModel product) async {
    await _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection("products")
        .add(product.toMap(product));
  }
}

// making it a global instance.(Singleton)
CloudFirestoreProvider cloudFirestore = CloudFirestoreProvider();
