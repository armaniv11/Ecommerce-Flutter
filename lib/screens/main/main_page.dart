import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dns/admin/add_product.dart';
import 'package:dns/app_constants.dart';
import 'package:dns/app_properties.dart';
import 'package:dns/controller.dart/productController.dart';
import 'package:dns/controller.dart/recentController.dart';
import 'package:dns/controller.dart/wishlistController.dart';

import 'package:dns/custom_classes/custom_classes.dart';
import 'package:dns/custom_classes/product_grid.dart';
import 'package:dns/custom_functions/custom_functions.dart';
import 'package:dns/custom_widgets/customControllerWidgets.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/functions/database.dart';
import 'package:dns/models/bannerModel.dart';
import 'package:dns/models/category.dart';
import 'package:dns/models/product.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/screens/address/add_address_page.dart';
import 'package:dns/screens/address/address_form.dart';
import 'package:dns/screens/demo/line.dart';
import 'package:dns/screens/gallery/product_categories.dart';
import 'package:dns/screens/main/bottombar.dart';
import 'package:dns/screens/product/view_product_page.dart';
import 'package:dns/screens/search.dart';
import 'package:dns/screens/shop/cart.dart';
import 'package:dns/screens/shop/check_out_page.dart';
import 'package:dns/screens/shop/wishlist.dart';
import 'package:dns/screens/sidebar.dart';
import 'package:dns/screens/tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'components/product_list.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

List<Category> categories = AppConstants.categoryList;

List<String> timelines = ['Weekly featured', 'Best of June', 'Best of 2018'];
String selectedTimeline = 'Weekly featured';
GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

List<BannerModel> banners = <BannerModel>[];

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  TabController? tabController;
  TabController? bottomTabController;
  GetStorage box = GetStorage();
  // ProductModel productModel = ProductModel();
  List productsAll = [];
  // ProductModel productModel = ProductModel(productpic: productpic, name: name, description: description, price: price, saleprice: saleprice, category: category, createdat: createdat, pid: pid, sellCount: sellCount)

  // List<ProductModel> shoppingList = <ProductModel>[];
  ShoppingController shoppingController = Get.find();
  RecentController recentController = Get.find();
  final WishListController wishListController = Get.put(WishListController());
  @override
  void initState() {
    super.initState();
    loadBanner();
    tabController = TabController(length: 5, vsync: this);
    bottomTabController = TabController(length: 4, vsync: this);
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDraweropen = false;
  DatabaseService databaseService = DatabaseService();
  var banner;
  Future loadBanner() async {
    setState(() {
      isLoading = true;
    });
    await databaseService.getCollection('Banners').then((value) {
      value.docs.forEach((element) {
        banners.add(BannerModel(element['name'], element['bannerpic']));
      });
      setState(() {
        isLoading = false;
      });
      //   banners.forEach((element) {
      //     print(element.bannerName);
      //   });
      //   setState(() {});
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top - 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CircleAvatar(
              child: Image.asset("assets/user.png"),
            ),
          ),
          Text(box.read(GetStorageConstants.signInName) ?? "Vinamra Jaiswal"),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProduct()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: FaIcon(FontAwesomeIcons.bell),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 4),
            child: Icon(Icons.shopping_cart),
          ),
        ],
      ),
    );

    Widget topHeader = Container(
        height: 120,
        width: double.maxFinite,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return CategoriesList(
                category: categories[index],
              );
            }));

    void indexChanged() {
      print("clicked");

      isDraweropen
          ? setState(() {
              xOffset = 0;
              yOffset = 0;
              scaleFactor = 1;
              isDraweropen = false;
            })
          : setState(() {
              xOffset = 250;
              yOffset = MediaQuery.of(context).size.height * 0.10;
              scaleFactor = 0.85;
              isDraweropen = true;
            });
      // _scaffoldKey.currentState!.openDrawer();
    }

    return Stack(
      children: [
        SideBar(
          key: _scaffoldKey,
        ),
        GestureDetector(
          onHorizontalDragUpdate: (dragUpdateDetails) {
            setState(() {
              xOffset = 0;
              yOffset = 0;
              scaleFactor = 1;
              isDraweropen = false;
            });
          },
          child: AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor),
            duration: Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              floatingActionButton: Visibility(
                  visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
                  child: FloatingButton()),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              bottomNavigationBar: BottomNavBar(indexChanged: indexChanged),
              // drawerEnableOpenDragGesture: false,
              drawer: SideBar(
                key: _scaffoldKey,
              ),
              body: ModalProgressHUD(
                inAsyncCall: isLoading,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      elevation: 0,
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                      backgroundColor: Colors.pink[900],
                      leading: Center(
                        child: CircleAvatar(
                            backgroundColor: Colors.grey[400],
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            )),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WishListCart()));
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => CheckOutPage()));
                          },
                          icon: Icon(Icons.favorite_rounded),
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TrackingPage()));
                            },
                            child: ImageIcon(
                              AssetImage('assets/icons/notification.png'),
                              size: 20,
                            ),
                          ),
                        ),
                        // IconButton(
                        //   splashRadius: 4,
                        //   onPressed: () {
                        //     // loadBanner();
                        //   },
                        //   icon: Image.asset(
                        //     'assets/icons/notification.png',
                        //     fit: BoxFit.fill,
                        //   ),

                        // ),
                        IconButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => AddAddressPage()));
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Line()));
                            },
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            )),
                      ],
                      // centerTitle: true,
                      // expandedHeight: size.height / 6.6,
                      title: Text(
                        GetStorage().read(GetStorageConstants.signInName) ??
                            "Hi! User",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      // flexibleSpace: FlexibleSpaceBar(
                      //   collapseMode: CollapseMode.parallax,
                      //   title: Text('Goa', textScaleFactor: 1),
                      //   // background: Image.asset(
                      //   //   'assets/firstScreen.png',
                      //   //   fit: BoxFit.fill,
                      //   // ),
                      // ),
                      pinned: true,
                      floating: true,
                      bottom: AppBar(
                          toolbarHeight: 55,
                          brightness: Brightness.dark,
                          automaticallyImplyLeading: false,
                          elevation: 8,
                          backgroundColor: Colors.pink[900],
                          // toolbarHeight: 10,
                          titleSpacing: 0,
                          title: Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 6, bottom: 6),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]!),
                                  borderRadius: BorderRadius.circular(2)),
                              child: TypeAheadField(
                                debounceDuration: Duration(milliseconds: 1000),
                                textFieldConfiguration: TextFieldConfiguration(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    autofocus: false,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[100],
                                      filled: true,
                                      // contentPadding: EdgeInsets.only(left: 10),
                                      suffixIcon: Icon(Icons.search),
                                      hintText:
                                          "Search by keyword or product ...",
                                      border: InputBorder.none,
                                    )),
                                suggestionsCallback: (product) async {
                                  return search(
                                      shoppingController.products, product);
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
                            ),
                          )),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          topHeader,
                          isLoading
                              ? Center(child: CircularProgressIndicator())
                              : BannerList(
                                  banners: banners,
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Divider(
                              thickness: 8,
                              color: Colors.grey[200],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomHeaderWithView(
                                text1: "Top",
                                text2: " Sellers",
                                text3: "View All",
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child:
                                gridviewOnly(shoppingController, 'TOPSELLERS'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Divider(
                              thickness: 8,
                              color: Colors.grey[200],
                            ),
                          ),
                          // Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: CustomHeaderWithView(
                          //       text1: "Top",
                          //       text2: " Rented",
                          //       text3: "View All",
                          //     )),
                          // // gridviewTopSellers,
                          // gridviewOnly(shoppingController, 'RENTED'),

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 20),
                          //   child: Divider(
                          //     thickness: 8,
                          //     color: Colors.grey[200],
                          //   ),
                          // ),
                          GetX<RecentController>(builder: (controller) {
                            return controller.countitems < 7 &&
                                    controller.countitems > 0
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomHeaderWithView(
                                      text1: "Recently",
                                      text2: " Viewed",
                                      text3: controller.countitems > 7
                                          ? "View All"
                                          : "",
                                    ))
                                : Container();
                          }),
                          gridviewRecent,
                          SizedBox(
                            height: 20,
                          ),

                          // tabBar
                          // createAnimatedMovieOverviewAndTicketInformationWidget(),
                        ],
                      ),
                    ),
                    // SliverChildDelegate()
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
