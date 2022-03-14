import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ProductListBloc {
  Query? query;
  int? limit;
  DocumentSnapshot? _lastDoc;
  bool? isLoading;
  bool? noMore;
  List<DocumentSnapshot>? documentList = <DocumentSnapshot>[];

  BehaviorSubject<List<DocumentSnapshot>>? productController;

  ProductListBloc() {
    query = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("products");
    limit = 10;
    isLoading = false;
    noMore = false;
    productController = BehaviorSubject<List<DocumentSnapshot>>();
    fetchFirstList();
  }

  Stream<List<DocumentSnapshot>> get productsStream =>
      productController!.stream;

  Future fetchFirstList() async {
    documentList = [];
    noMore = false;
    _lastDoc = null;
    isLoading = true;
    QuerySnapshot _querySnapshot = await query!.limit(limit!).get();
    if (_querySnapshot.size != 0) {
      _lastDoc = _querySnapshot.docs[_querySnapshot.size - 1];
      documentList?.addAll(_querySnapshot.docs);
      productController?.sink.add(documentList!);
      // if (_querySnapshot.size < 10) {
      // productController?.sink.();
      // }
    } else {
      productController?.sink.add(documentList!);
    }
    isLoading = false;
  }

/*This will automatically fetch the next 10 elements from the list*/
  fetchNextProducts() async {
    if (!isLoading!) {
      isLoading = true;
      QuerySnapshot _querySnapshot =
          await query!.startAfterDocument(_lastDoc!).limit(limit!).get();
      if (_querySnapshot.size == 0) {
        noMore = true;
      }
      print(noMore);
      if (!noMore!) {
        print(noMore);
        _lastDoc = _querySnapshot.docs[_querySnapshot.size - 1];
        print(_lastDoc);
        print(_querySnapshot.docs.length);
        documentList!.addAll(_querySnapshot.docs);
        print(documentList!.length);
        productController!.sink.add(documentList!);
      }
      isLoading = false;
    }
  }

  void dispose() {
    productController!.close();
    // showIndicatorController.close();
  }
}
