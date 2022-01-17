import 'package:dns/controller.dart/productController.dart';
import 'package:dns/custom_functions/custom_functions.dart';
import 'package:dns/models/product.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/screens/product/view_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final ShoppingController shoppingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        iconTheme: IconThemeData(color: Colors.white),
        title: Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Container(
              height: 47,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TypeAheadField(
                  debounceDuration: Duration(milliseconds: 1000),
                  textFieldConfiguration: TextFieldConfiguration(
                      textCapitalization: TextCapitalization.words,
                      autofocus: true,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      decoration: InputDecoration(
                          // contentPadding: EdgeInsets.only(left: 10),
                          suffixIcon: Icon(Icons.search),
                          hintText: "Search here . . .",
                          border: InputBorder.none)),
                  suggestionsCallback: (product) async {
                    return search(shoppingController.products, product);
                  },
                  itemBuilder: (context, ProductModel product) {
                    return ListTile(
                      tileColor: Colors.white,
                      // leading: Icon(Icons.shopping_cart),
                      title: Text(product.name!),
                      // subtitle: Text('\$${suggestion['price']}'),
                    );
                  },
                  onSuggestionSelected: (ProductModel product) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ViewProductPage(product: product)));
                  },
                ),
              )),
        ),
      ),
    );
  }
}
