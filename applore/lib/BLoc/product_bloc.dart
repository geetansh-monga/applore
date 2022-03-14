// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rxdart/rxdart.dart';

// class ProductListBloc {
//   Query? query;
//   int? limit;
//   DocumentSnapshot? _lastDoc;
//   bool? isLoading;
//   bool? noMore;
//   List<DocumentSnapshot>? documentList = <DocumentSnapshot>[];

//   BehaviorSubject<List<DocumentSnapshot>>? productController;

//   ProductListBloc() {
//     query = FirebaseFirestore.instance.collection("");
//     limit = limit;
//     isLoading = false;
//     noMore = false;
//     productController = BehaviorSubject<List<DocumentSnapshot>>();
//     fetchFirstList();
//   }

//   Stream<List<DocumentSnapshot>> get followsStream => productController!.stream;

//   Future fetchFirstList() async {
//     QuerySnapshot _querySnapshot = await query!.limit(limit!).get();

//     _lastDoc = _querySnapshot.docs[_querySnapshot.size - 1];
//     documentList?.addAll(_querySnapshot.docs);
//     productController?.sink.add(documentList!);
//   }

// /*This will automatically fetch the next 10 elements from the list*/
//   fetchNextFollows() async {
//     if (!isLoading!) {
//       isLoading = true;
//       QuerySnapshot _querySnapshot =
//           await query!.startAfterDocument(_lastDoc!).limit(limit!).get();
//       if (_querySnapshot.size == 0) {
//         noMore = true;
//         productController!.sink.close();
//       }
//       print(noMore);
//       if (!noMore!) {
//         print(noMore);
//         _lastDoc = _querySnapshot.docs[_querySnapshot.size - 1];
//         print(_lastDoc);
//         print(_querySnapshot.docs.length);
//         documentList!.addAll(_querySnapshot.docs);
//         print(documentList!.length);
//         // await Future.delayed(Duration(seconds: 1));
//         productController!.sink.add(documentList!);
//       }
//       isLoading = false;
//     }
//   }

//   void dispose() {
//     productController!.close();
//     // showIndicatorController.close();
//   }
// }
