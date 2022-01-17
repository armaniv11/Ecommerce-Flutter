import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dns/app_constants.dart';
import 'package:dns/controller.dart/productCategoryController.dart';
import 'package:dns/custom_classes/custom_classes.dart';
import 'package:dns/custom_classes/product_grid.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/models/category.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/screens/product/view_product_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

class ProductCategoryPage extends StatefulWidget {
  final Category? category;
  const ProductCategoryPage({Key? key, required this.category})
      : super(key: key);

  @override
  _ProductCategoryPageState createState() => _ProductCategoryPageState();
}

final ProductCategoryController productCategoryController = Get.find();
int gadgetsLength = 0;
int clothesLength = 0;
int productLength = 0;
List<ProductModel> categoryProducts = <ProductModel>[];
List<ProductModel> initialProducts = <ProductModel>[];

bool isLoading = true;

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    categoryProducts = [];
    // categoryController.
    // int clo = productCategoryController.countClothes;
    // print("printing count");
    // print(clo.toString());
    // if (clo == 0) {
    // productCategoryController.setClothes(category: 'Clothes');
    // }
    // loadProducts();
    checkProducts();

    // categoryController.
    // TODO: implement initState
    super.initState();
  }

  checkProducts() async {
    print(widget.category!.category);

    // productLength = productCategoryController.countClothes;
    initialProducts = categoryProducts = await productCategoryController
        .checkAndLoadProducts(widget.category!.category);

    // categoryProducts.forEach((element) {
    //   print(element.name);
    // });
    if (initialProducts.length > 0)
      setState(() {
        isLoading = false;
      });
    // categoryProducts.t
  }

  // List<ProductModel> clothes = <ProductModel>[];

  // Future<void> loadProducts() async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('Products')
  //       .where('category', isEqualTo: 'Clothes')
  //       .get();
  //   clothes = querySnapshot.docs
  //       .map((m) => ProductModel.fromJson(m.data() as Map<String, dynamic>))
  //       .toList();
  //   print(clothes);
  //   // return catInfo;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget gridview = isLoading
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // childAspectRatio: 1 / 1,
                    mainAxisExtent: 270,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10),
                itemCount: categoryProducts.length,
                itemBuilder: (BuildContext ctx, index) {
                  return ProductGrid(product: categoryProducts[index]);
                }));

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: false,
            leadingWidth: 10,
            // shadowColor: Colors.yellow,

            // elevation: 8,
            // forceElevated: true,

            // toolbarHeight: 220,
            expandedHeight: 250.0,
            brightness: Brightness.dark,
            backgroundColor: Colors.pink[800],

            // title: Text(
            //   "Vinamra Jaiswal",
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 14,
            //       fontWeight: FontWeight.bold),
            // ),
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              title: Transform(
                transform: Matrix4.translationValues(-80, 0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 38, right: 12, bottom: 4, top: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      gradient: LinearGradient(colors: [
                        widget.category!.begin,
                        widget.category!.end
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: Text(widget.category!.category,
                        style: TextStyle(color: Colors.white),
                        textScaleFactor: 1),
                  ),
                ),
              ),
              background: Hero(
                tag: widget.category!,
                child: Image.asset(
                  widget.category!.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            pinned: true,
            floating: true,
            // snap: true,
            bottom: AppBar(
              bottomOpacity: 0,
              // toolbarHeight: 60,
              // automaticallyImplyLeading: false,

              // elevation: 8,
              backgroundColor: Colors.transparent,
              // toolbarHeight: 10,
              titleSpacing: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.sort),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.shopping_cart),
                )
              ],
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  // height: 47,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey)),
                  child: TextField(
                    controller: searchController,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (String val) {
                      if (searchController.text.isNotEmpty) {
                        List<ProductModel> asd = <ProductModel>[];
                        categoryProducts.forEach((element) {
                          print(element.name);
                          print(searchController.text);
                          if (element.name!.contains(searchController.text)) {
                            print(element.name);
                            asd.add(element);
                          }
                        });
                        categoryProducts = asd;
                        setState(() {});
                      } else {
                        categoryProducts = initialProducts;
                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: searchController.text.isEmpty
                            ? null
                            : InkWell(
                                onTap: () {
                                  searchController.clear();
                                  categoryProducts = initialProducts;
                                },
                                child: Icon(Icons.cancel_outlined)),
                        border: InputBorder.none,
                        hintText: 'Search here',
                        hintStyle: TextStyle(fontSize: 12)),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                gridview,
              ],
            ),
          ),
          // SliverChildDelegate()
        ],
      ),
    );
  }
}
