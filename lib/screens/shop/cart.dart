import 'dart:ui';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dns/app_constants.dart';
import 'package:dns/controller.dart/cartController.dart';
import 'package:dns/custom_classes/product_grid.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/screens/address/add_address_page.dart';
import 'package:dns/screens/product/components/addToCartBottomSheet.dart';
import 'package:dns/screens/product/view_product_page.dart';
import 'package:dns/screens/shop/components/tracking_list.dart';
import 'package:dns/screens/shop/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:im_stepper/stepper.dart';

class ShoppingCart extends StatelessWidget {
  ShoppingCart({Key? key}) : super(key: key);
  TextEditingController couponController = TextEditingController();
  final CartController cartController = Get.find();
  int activeStep = 0; // Initial step set to 5.

  int upperBound = 3;

  @override
  Widget build(BuildContext context) {
    Widget rowTwoChild(child1, child2,
        {bool iconshow: false,
        IconData icon: Icons.add,
        FontWeight weight: FontWeight.normal}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              child1,
              style: TextStyle(fontSize: 12, fontWeight: weight),
            ),
            Spacer(),
            iconshow
                ? FaIcon(
                    icon,
                    size: 12,
                    color: Colors.grey[400],
                  )
                : Container(),
            SizedBox(
              width: 6,
            ),
            FaIcon(
              FontAwesomeIcons.rupeeSign,
              size: 10,
              color: Colors.grey[400],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                child2,
                style: TextStyle(fontSize: 12, fontWeight: weight),
              ),
            )
          ],
        ),
      );
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WishListCart()));
              },
              icon: FaIcon(
                FontAwesomeIcons.heart,
                color: Colors.pink,
              )),
        ],
        title: GetX<CartController>(builder: (controller) {
          return Text(
            "Cart ( ${controller.countitems} )",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: FloatingActionButton.extended(
            // backgroundColor: Colors.transparent,
            onPressed: () {},
            label: Material(
              elevation: 8,
              child: Container(
                height: 80,
                width: size.width,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[800]!,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.blue,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Cart Total",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            shadows: <Shadow>[
                              Shadow(
                                // offset: Offset(10.0, 10.0),
                                blurRadius: 2.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Shadow(
                                // offset: Offset(10.0, 10.0),
                                blurRadius: 2.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        GetX<CartController>(builder: (controller) {
                          return Text(
                            "Rs.${controller.cartPrice}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          );
                        }),
                      ],
                    ),
                    GetX<CartController>(builder: (controller) {
                      return controller.countitems == 0
                          ? InkWell(
                              onTap: () {
                                customToast("Add items to cart first!!");
                              },
                              child: customButton("Confirm Address",
                                  width: size.width / 2.3,
                                  color: Colors.white54,
                                  backgroundColor: Colors.grey))
                          : InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddAddressPage()));
                                // var asd =
                                //     await cartController.addToCart(widget.product);
                              },
                              child: customButton("Confirm Address",
                                  icon: Icons.arrow_forward,
                                  fontsize: 14,
                                  width: size.width / 2));
                    })
                  ],
                ),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TrackingList(
              activestep: 0,
              icons: AppConstants.trackingIconOrder,
              // Icon(Icons.supervised_user_circle),
              // Icon(Icons.flag),
              // Icon(Icons.access_alarm),
              // Icon(Icons.supervised_user_circle),
            ),
            GetX<CartController>(builder: (controller) {
              return controller.countitems == 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 140),
                      child: EmptyCartShow(
                        emptyText: "Cart is Empty !!",
                      ),
                    )
                  : Column(
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.cartItems.length,
                            itemBuilder: (context, index) {
                              return CartList(
                                product: controller.cartItems[index],
                                index: index,
                                cartType: "CART",
                              );
                            }),
                        // Divider(
                        //   thickness: 6,
                        //   color: Colors.grey[200],
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 12, bottom: 8, left: 12, right: 12),

                            width: size.width,
                            // height: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: customText("Promo Code",
                                      size: 14, fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1, horizontal: 12),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey[200]!, width: 2),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          // color: Colors.blue,
                                          width: size.width * 0.65,
                                          child: TextField(
                                            controller: couponController,
                                            onChanged: (val) {
                                              print(couponController.text);
                                            },
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.none,
                                                fontSize: 18),
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Enter Promo Code Here",

                                                // suffixText: suffixText,
                                                // errorStyle: TextStyle(color: Colors.white),
                                                // prefixIcon: icon,
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[300],
                                                    fontSize: 16),
                                                // filled: true,
                                                isDense: false,
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "APPLY",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                couponController.text.length <
                                                        10
                                                    ? Colors.grey[400]
                                                    : Colors.blue[900]),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 6,
                          color: Colors.grey[200],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12),
                          child: Container(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            width: size.width,
                            // height: 120,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: customText("Price Breakup",
                                      size: 14, fontWeight: FontWeight.bold),
                                ),
                                Divider(),
                                GetX<CartController>(builder: (controller) {
                                  return rowTwoChild(
                                    "Order Price",
                                    controller.cartBeforeTax.toString(),
                                  );
                                }),
                                GetX<CartController>(builder: (controller) {
                                  return rowTwoChild(
                                      "Taxes", controller.getCartTax.toString(),
                                      iconshow: true, icon: Icons.add);
                                }),
                                // rowTwoChild("Tax", cartController.getCartTax.toString(),
                                //     iconshow: true, icon: Icons.add),
                                GetX<CartController>(builder: (controller) {
                                  return rowTwoChild("Shipping Charges",
                                      controller.cartShipping.toString(),
                                      iconshow: true, icon: Icons.add);
                                }),
                                // rowTwoChild("Shipping Charges",
                                //     cartController.cartShipping.toString(),
                                //     iconshow: true, icon: Icons.add),
                                // GetX<CartController>(builder: (controller) {
                                //   return rowTwoChild(
                                //       "Taxes", controller.getCartTax.toString(),
                                //       iconshow: true, icon: Icons.remove);
                                // }),
                                rowTwoChild("Coupon / Discount", "0".toString(),
                                    iconshow: true, icon: Icons.remove),
                                Divider(
                                  thickness: 1.5,
                                ),
                                GetX<CartController>(builder: (controller) {
                                  return rowTwoChild(
                                      "Total", controller.cartPrice.toString(),
                                      weight: FontWeight.bold);
                                }),
                                // rowTwoChild(
                                //     "Order Total", cartController.cartPrice.toString(),
                                //     weight: FontWeight.bold),
                                // Divider(
                                //   thickness: 1.5,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
            }),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyCartShow extends StatelessWidget {
  const EmptyCartShow({
    Key? key,
    required this.emptyText,
  }) : super(key: key);
  final String? emptyText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(
        //   height: 120,
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ImageIcon(
            AssetImage('assets/icons/empty-cart.png'),
            color: Colors.white,
            size: 90,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          emptyText!,
          style: TextStyle(
              color: Colors.grey[200],
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        // SizedBox(
        //   height: 60,
        // ),
      ],
    );
  }
}

class CartList extends StatelessWidget {
  final ProductModel? product;
  final index;
  final String? cartType;
  CartList({required this.product, this.index, required this.cartType});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 4, left: 12, right: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewProductPage(product: product)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white, width: 2),
                      // shape: BoxShape.circle,
                      color: Colors.yellow[800],
                      image: DecorationImage(
                          image: NetworkImage(product!.productpic!),
                          fit: BoxFit.fill)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      product!.name!,
                      maxLines: 2,
                      style: TextStyle(
                          fontFamily: 'teko',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey,
                          letterSpacing: 1),
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: FaIcon(
                          FontAwesomeIcons.rupeeSign,
                          color: Colors.grey,
                          size: 8,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          "${product!.saleprice}",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              color: Colors.grey[400]),
                        ),
                      ),
                      Text(
                        " X ${product!.quantity} pcs.",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      )
                      // Positioned(bottom: 5, child: Icon(Icons.ac_unit)),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: FaIcon(
                          FontAwesomeIcons.rupeeSign,
                          color: Colors.grey,
                          size: 10,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              "${product!.saleprice! * product!.quantity!}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  letterSpacing: 1.4,
                                  color: Colors.pink),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          cartType == AppConstants.wishlist
                              ? InkWell(
                                  onTap: () {
                                    cartController.addToCart(product!);
                                    wishListController.deleteFromWishlist(
                                        index, product!);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.green[800],
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: customText("Move to Cart",
                                          size: 12, color: Colors.white)),
                                )
                              : Container()
                        ],
                      ),
                      // Positioned(bottom: 5, child: Icon(Icons.ac_unit)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 80, child: VerticalDivider()),
              InkWell(
                onTap: () {
                  if (cartType == AppConstants.cart)
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return AddToCartBottomSheet(
                          product: product,
                          cartType: AppConstants.cart,
                          // index:index
                          // callback: changeCart,
                        );
                      },
                    );
                  else {
                    wishListController.deleteFromWishlist(index, product!);
                  }
                },
                child: Icon(
                  cartType == AppConstants.cart
                      ? Icons.arrow_forward_ios
                      : Icons.cancel_sharp,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
