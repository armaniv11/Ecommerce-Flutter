import 'package:dns/admin/components/each_tag.dart';
import 'package:dns/app_constants.dart';
import 'package:dns/controller.dart/cartController.dart';
import 'package:dns/controller.dart/productController.dart';
import 'package:dns/models/category.dart';
import 'package:dns/models/product.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/screens/gallery/product_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_product.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final ShoppingController shoppingController = Get.find();
  final CartController cartController = Get.find();

  List<Widget> tags = [];
  List<Category> all = [];
  List<ProductModel> searchResults = [];

  @override
  void initState() {
    // all = AppConstants.categoryList;
    // // all.insert(
    // //     0,
    // //     Category(
    // //       Color(0xffFCE183),
    // //       Color(0xffF68D7F),
    // //       'All',
    // //       'assets/gadget.jpg',
    // //     ));
    // all.forEach((element) {
    //   print(element.category);
    // });
    loadTags();
    loadData(AppConstants.categoryAllList[0].category);

    // TODO: implement initState
    super.initState();
  }

  String activeCategory = '';

  void changeActiveCategory(String cat) {
    setState(() {
      isLoading = true;
      activeCategory = cat;
      print("$activeCategory printing active category after callback");
      tags.clear();
      loadTags();
      isLoading = false;
    });
  }

  loadTags() async {
    AppConstants.categoryAllList.forEach((element) {
      tags.add(EachTag(
        categoryName: element,
        active: activeCategory,
        callBack: changeActiveCategory,
      ));
    });
    setState(() {
      isLoading = false;
    });
  }

  _displayTagWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: tags.isNotEmpty ? _buildSuggestionWidget() : Text('No tags added'),
    );
  }

  Widget _buildSuggestionWidget() {
    return Wrap(alignment: WrapAlignment.start, children: techChips().toList());
  }

  int selectedIndex = 0;

  List<Widget> techChips() {
    List<Widget> chips = [];
    for (int i = 0; i < AppConstants.categoryAllList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: ChoiceChip(
          label: Text(AppConstants.categoryAllList[i].category),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.grey[400],
          shadowColor: Colors.yellow,
          selectedShadowColor: Colors.yellow,
          selectedColor: Colors.green,
          selected: selectedIndex == i,
          onSelected: (bool value) {
            setState(() {
              isLoading = true;
              selectedIndex = i;
              loadData(AppConstants.categoryAllList[i].category);
              // shoppingController
              //     .filterByCategory(AppConstants.categoryList[i].category)
              //     .then((value) {
              //   setState(() {
              //     searchResults = value;
              //   });
              // });
              isLoading = false;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  loadData(String asd) async {
    await shoppingController.filterByCategory(asd).then((value) {
      setState(() {
        searchResults = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[900],
          title: Text("All Products"),
          elevation: 0,
          actions: [],
          // flexibleSpace: Container(
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(tileMode: TileMode.mirror,
          //           // begin: Alignment.topLeft,
          //           // end: Alignment.bottomRight,
          //           colors: <Color>[Colors.pink[900]!, Colors.pink])),
          // ),
        ),
        backgroundColor: Colors.grey[100],
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 4),
                      width: size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              tileMode: TileMode.mirror,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                            Colors.pink[900]!,
                            Colors.pink[900]!,
                            Colors.pink[900]!,
                            Colors.pink[900]!,
                            Colors.pink[900]!,
                            Colors.pink[900]!,
                            Colors.pink[900]!,
                            Colors.pink[100]!,
                            // Colors.black54
                          ])),
                      child: _displayTagWidget()),
                  // Divider(
                  //   color: Colors.yellow[50],
                  //   thickness: 10,
                  // ),
                  // Wrap(alignment: WrapAlignment.start, children: tags.toList()),
                  searchResults.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red[100]),
                            child: Text("No Product Found!!"),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              // shrinkWrap: true,
                              itemCount: searchResults.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    title: Text(
                                        searchResults[index].name.toString()),
                                    leading: Container(
                                      height: 60,
                                      width: 60,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        // backgroundColor: Colors.white,
                                        // minRadius: 10,
                                        child: Image.network(
                                          searchResults[index].productpic!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddProduct(
                                                        productId:
                                                            shoppingController
                                                                .products[index]
                                                                .pid,
                                                      )));
                                        },
                                        icon: Icon(Icons.arrow_forward_ios)),
                                  ),
                                );
                              }),
                        ),
                ],
              ));
  }
}
