import 'package:dns/app_constants.dart';
import 'package:dns/controller.dart/cartController.dart';
import 'package:dns/controller.dart/productCategoryController.dart';
import 'package:dns/controller.dart/recentController.dart';
import 'package:dns/controller.dart/wishlistController.dart';
import 'package:dns/custom_classes/custom_classes.dart';
import 'package:dns/custom_classes/product_grid.dart';
import 'package:dns/custom_widgets/customControllerWidgets.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/models/product.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/models/reviewModel.dart';
import 'package:dns/screens/product/components/addToCartBottomSheet.dart';
import 'package:dns/screens/product/components/rating_bottomSheet.dart';
import 'package:dns/screens/search_page.dart';
import 'package:dns/screens/shop/cart.dart';
import 'package:dns/screens/shop/check_out_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ViewProductPage extends StatefulWidget {
  final ProductModel? product;

  ViewProductPage({required this.product});

  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  CartController cartController = Get.find();
  final WishListController wishListController = Get.find();
  final RecentController recentController = Get.find();
  final ProductCategoryController productCategoryController = Get.find();

  List<ReviewModel> reviews = <ReviewModel>[];
  @override
  void initState() {
    widget.product!.reviews!.forEach((key, value) {
      reviews.add(ReviewModel.fromJson(value));
    });
    loadSimilar();
    // addToRecent();
    Future.delayed(Duration(milliseconds: 1000), () async {
      await recentController.addToRecentList(widget.product);

      // Your Function
    });
    // recentController.addToRecentList(widget.product);

    // TODO: implement initState
    super.initState();
  }

  bool inCart = false;
  bool inWishList = false;
  bool isLoading = true;

  changeCart(bool cur) {
    setState(() {
      inCart = cur;
    });
  }

  List<ProductModel> similarProducts = [];
  loadSimilar() async {
    await productCategoryController
        .checkAndLoadProducts(widget.product!.category)
        .then((value) {
      similarProducts = value.take(6).toList();
      setState(() {
        isLoading = false;
      });
    });
    similarProducts.forEach((element) {
      print(element.createdat);
    });
    // setState(() {
    //   isLoading = false;
    // });
  }

  addToRecent() async {
    await recentController.addToRecentList(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.product.reviews!.entries);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.transparent,
          onPressed: () {},
          label: Container(
            height: 60,
            width: size.width - 10,
            decoration: BoxDecoration(
                color: Colors.black87.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                        onPressed: () {
                          wishListController.addToWishList(widget.product!);
                          setState(() {
                            inWishList = !inWishList;
                          });
                        },
                        icon: Icon(
                          inWishList
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          size: 32,
                          color: Color(0xffFF8993),
                        ))),
                Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          size: 28,
                        ))),
                GetX<CartController>(builder: (controller) {
                  return controller.checkInCart(widget.product)
                      ? Expanded(
                          child: InkWell(
                              onTap: () async {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return AddToCartBottomSheet(
                                      product: widget.product,
                                      // callback: changeCart,
                                    );
                                  },
                                );
                                // var asd =
                                //     await cartController.addToCart(widget.product);
                              },
                              child: customButton("Added",
                                  backgroundColor: Colors.green)),
                        )
                      : Expanded(
                          child: InkWell(
                              onTap: () async {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return AddToCartBottomSheet(
                                      product: widget.product,
                                      // callback: changeCart,
                                    );
                                  },
                                  // elevation: 10,
                                  //backgroundColor: Colors.transparent
                                );
                                // var asd =
                                //     await cartController.addToCart(widget.product);
                              },
                              child: customButton("Add To Cart")));
                }),
              ],
            ),
          )),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            expandedHeight: size.height / 2,
            brightness: Brightness.dark,
            backgroundColor: Colors.pink[900],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              // title: Text('Goa', textScaleFactor: 1),
              background: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 60,
                ),
                child: Image.network(
                  widget.product!.productpic!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            pinned: true,
            floating: true,
            // snap: true,
            stretch: true,
            bottom: AppBar(
              toolbarHeight: 60,
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),

              elevation: 8,
              backgroundColor: Colors.pink[900],
              actions: [
                // customCircularIcon(Colors.white, Colors.grey, Icons.search),
                customCircularIcon(
                    Colors.white, Colors.pink, FontAwesomeIcons.heart),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => ShoppingCart()));
                    },
                    child: customCircularIcon(Colors.white, Colors.grey,
                        Icons.shopping_cart_outlined))
              ],
              // toolbarHeight: 10,
              titleSpacing: 0,

              // centerTitle: true,
              title: Container(
                width: size.width / 2,
                child: Text(
                  widget.product!.name!,
                  maxLines: 3,
                  // overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // topHeader,

                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      iconWithText(FontAwesomeIcons.rupeeSign, 14.0,
                          widget.product!.saleprice.toString(),
                          fontsize: 28),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6, left: 8),
                        child: iconWithText(FontAwesomeIcons.rupeeSign, 8.0,
                            widget.product!.price.toString(),
                            color: Colors.red.shade800,
                            fontsize: 14,
                            textDecoration: TextDecoration.lineThrough),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: textWithIcon(
                            Icons.star, 12.0, "${widget.product!.rating * 5}",
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.product!.deliveryCharge <= 1
                          ? containerText("Free Delivery!!")
                          : Container(),
                      containerText(
                          "${widget.product!.reviews!.length} Reviews"),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    thickness: 8,
                    color: Colors.grey[200],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomHeaderWithView(
                      text1: "Product",
                      text2: " Description",
                      text3: "",
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        "Category: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.product!.category ?? "",
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                widget.product!.category == AppConstants.categoryClothes
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            Text(
                              "Wash Care: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.product!.careInstructions ?? "",
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    widget.product!.desc ?? "",
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey[100]),
                          child: RatingBar(
                            //                      borderColor: Color(0xffFF8993),
                            //                      fillColor: Color(0xffFF8993),
                            ignoreGestures: true,
                            itemSize: 24,
                            allowHalfRating: true,
                            glowColor: Colors.black,
                            initialRating: widget.product!.rating * 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            ratingWidget: RatingWidget(
                              empty: Icon(Icons.favorite_border,
                                  color: Color(0xffFF8993), size: 20),
                              full: Icon(
                                Icons.favorite,
                                color: Color(0xffFF8993),
                                size: 20,
                              ),
                              half: Image.asset('assets/icons/half_heart.png'),
                            ),
                            onRatingUpdate: (value) {
                              setState(() {
                                // rating = value;
                              });
                              print(value);
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return RatingBottomSheet(
                                  reviews: reviews,
                                  productName: widget.product!.name,
                                  image: widget.product!.productpic,
                                );
                              },
                              // elevation: 10,
                              //backgroundColor: Colors.transparent
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: customText("Read Reviews",
                                  size: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // gridviewTopSellers,
                similarProducts.length == 0
                    ? Container()
                    : Column(
                        children: [
                          Divider(
                            thickness: 8,
                            color: Colors.grey[200],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 8),
                            child: CustomHeaderWithView(
                              text1: "Similar",
                              text2: " Products",
                              text3: "",
                            ),
                          )
                        ],
                      ),

                GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // childAspectRatio: 1 / 1,
                            mainAxisExtent: 270,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10),
                    itemCount: similarProducts.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return ProductGrid(product: similarProducts[index]);
                    }),
                SizedBox(
                  height: 70,
                )

                // tabBar
                // createAnimatedMovieOverviewAndTicketInformationWidget(),
              ],
            ),
          ),
          // SliverChildDelegate()
        ],
      ),
    );
  }
}
