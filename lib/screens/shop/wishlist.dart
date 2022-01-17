import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dns/controller.dart/cartController.dart';
import 'package:dns/controller.dart/wishlistController.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/screens/address/add_address_page.dart';
import 'package:dns/screens/shop/cart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

class WishListCart extends StatelessWidget {
  WishListCart({Key? key}) : super(key: key);
  final WishListController wishListController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                )),
          ],
          title: GetX<WishListController>(builder: (controller) {
            return Text(
              "Wishlist ( ${controller.countitems} )",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            );
          }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.transparent,
            onPressed: () {},
            label: Container(
              height: 80,
              width: size.width,
              decoration: BoxDecoration(
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
                        "Total",
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
                      GetX<WishListController>(builder: (controller) {
                        return Text(
                          "Rs.${controller.wishListPrice}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        );
                      }),
                    ],
                  ),
                  InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShoppingCart()));
                        // var asd =
                        //     await cartController.addToCart(widget.product);
                      },
                      child: customButton("View Cart", width: size.width / 2.3))
                ],
              ),
            )),
        body: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Colors.pink[900],
                // gradient: LinearGradient(
                //   colors: [
                //     Colors.grey[300]!,
                //     Colors.grey[200]!,
                //     Colors.grey[100]!,
                //     Colors.grey[200]!
                //   ],
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   // stops: [0, 0, 0.6, 1],
                // ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: GetX<WishListController>(builder: (controller) {
              return controller.countitems == 0
                  ? EmptyCartShow(emptyText: "Wishlist is Empty !!")
                  : Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.wishlist.length,
                            itemBuilder: (context, index) {
                              return CartList(
                                product: controller.wishlist[index],
                                index: index,
                                cartType: "WISHLIST",
                              );
                            }),
                        SizedBox(
                          height: 80,
                        )
                      ],
                    );
            })));
  }
}
