import 'package:applore/ui/add-product-screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:applore/ui/widgets/logout_button.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        automaticallyImplyLeading: false,
        actions: const [LogoutButton()],
      ),
      body: FutureBuilder<QuerySnapshot>(builder: (context, snapshot) {
        return ListView.builder(itemBuilder: ((context, index) {}));
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // ignore: avoid_print
          print("add product");
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddProductScreen()));
        },
      ),
    );
  }
}
