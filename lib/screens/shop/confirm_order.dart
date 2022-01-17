import 'package:dns/controller.dart/cartController.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/screens/shop/cart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../app_properties.dart';

class ConfirmOrder extends StatelessWidget {
  final String? address;
  const ConfirmOrder({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final CartController cartController = Get.find();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: darkGrey),
        elevation: 0,
        backgroundColor: Colors.grey[100],
        title: Text(
          'Confirm Order',
          style: const TextStyle(
              color: darkGrey,
              fontWeight: FontWeight.w500,
              fontFamily: "Montserrat",
              fontSize: 18.0),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text("Shipping Address"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: EdgeInsets.all(8),
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: Text(this.address!)),
          ),
          GetX<CartController>(builder: (controller) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  return CartListMini(
                    product: controller.cartItems[index],
                  );
                });
          }),
        ],
      ),
    );
  }
}

class CartListMini extends StatelessWidget {
  final ProductModel? product;
  CartListMini({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white, width: 2),
                      // shape: BoxShape.circle,
                      // color: Colors.yellow[800],
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
                    // width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      product!.name!,
                      style: TextStyle(
                          fontFamily: 'teko',
                          fontSize: 16,
                          color: Colors.grey,
                          letterSpacing: 1.4),
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Quantity: ',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: '1',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.rupeeSign,
                        color: Colors.grey[800],
                        size: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          product!.price.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              letterSpacing: 1.4,
                              color: Colors.pink),
                        ),
                      ),
                      // Positioned(bottom: 5, child: Icon(Icons.ac_unit)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            right: 10,
            top: 10,
            child: Icon(
              Icons.delete_outline_outlined,
              color: Colors.red,
            ))
      ]),
    );
  }
}
