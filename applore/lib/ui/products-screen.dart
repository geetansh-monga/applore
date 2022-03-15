import 'package:applore/BLoc/product_bloc.dart';
import 'package:applore/model/product-model.dart';
import 'package:applore/ui/add-product-screen.dart';
import 'package:applore/ui/widgets/product-tile.dart';
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
  late ProductListBloc products;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late ScrollController scrollController0;

// scroll listner defined.
  _scrollListener0() {
    double maxScroll = scrollController0.position.maxScrollExtent;
    double currentScroll = scrollController0.offset;
    double delta = MediaQuery.of(context).size.height * 0.05;
    if (maxScroll - currentScroll < delta) {
      products.fetchNextProducts();
    }
  }

  @override
  void initState() {
    super.initState();

    products = ProductListBloc();
    scrollController0 = ScrollController();
    scrollController0.addListener(_scrollListener0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        automaticallyImplyLeading: false,
        actions: const [LogoutButton()],
      ),
      body: StreamBuilder<List<DocumentSnapshot>>(
        stream: products.productsStream,
        builder: (context, snapshot) => (!snapshot.hasData)
            ? const CircularProgressIndicator()
            : snapshot.data!.isEmpty
                ? const Center(
                    child:
                        Text("Sorry there are no products added please add."))
                : SingleChildScrollView(
                    controller: scrollController0,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      cacheExtent: 500,
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ProductTile(
                            product:
                                ProductModel.fromMap(snapshot.data![index]));
                      },
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          // ignore: avoid_print
          print("add product");

          //checking if new product is added when add floating widget typed.
          bool? _isNewProductAdded = await Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddProductScreen()));
          if (_isNewProductAdded != null) {
            await products.fetchFirstList();

            // scrolling animation to make it on top.
            scrollController0.animateTo(1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          }
        },
      ),
    );
  }
}
