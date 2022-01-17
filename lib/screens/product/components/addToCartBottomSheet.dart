import 'package:dns/app_properties.dart';
import 'package:dns/controller.dart/cartController.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/models/product.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/models/reviewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class AddToCartBottomSheet extends StatefulWidget {
  // final ValueChanged<bool> callback;
  final ProductModel? product;
  final String cartType;
  AddToCartBottomSheet({
    required this.product,
    this.cartType = 'CART',
  });
  @override
  _AddToCartBottomSheetState createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  double rating = 2.0;
  List<int> ratings = [2, 1, 5, 2, 4, 3];
  int? qty = 1;
  final CartController cartController = Get.find();
  @override
  void initState() {
    if (cartController.checkInCart(widget.product)) {
      qty = widget.product!.quantity;
    }

    // qty = widget.product.quantity == null ? 1 : widget.product.quantity!;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("At Start");
    // print(widget.product.quantity);
    // widget.reviews!.forEach((element) {

    //   print(element.reviewDate);
    // });
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 12),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.9),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24))),
      child:
          // ListView(
          //   children: <Widget>[
          SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                // padding: const EdgeInsets.all(8.0),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.product!.productpic!),
                      fit: BoxFit.fill),
                  color: yellow,
                  // shape: BoxShape.rectangle,
                  boxShadow: shadow,
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.all(width: 8.0, color: Colors.white)
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 72.0, vertical: 16.0),
              child: Text(
                widget.product!.name!,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(),
            Container(
              height: 60,
              width: size.width / 2.2,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: InkWell(
                        onTap: () {
                          print("$qty in minus");
                          if (qty! > 1)
                            setState(() {
                              qty = qty! - 1;
                              print(qty);
                            });
                        },
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // GetX<CartController>(builder: (controller) {

                  Text(
                    qty.toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  // }),
                  InkWell(
                    onTap: () {
                      print("${widget.product!.maxSaleQty} max sale");
                      if (qty! < 2)
                        setState(() {
                          qty = qty! + 1;
                          print(qty);
                        });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GetX<CartController>(builder: (controller) {
              if (controller.checkInCart(widget.product)) {
                return Column(
                  children: [
                    InkWell(
                        onTap: () {
                          ProductModel pro = widget.product!;
                          pro.quantity = qty;
                          cartController.addToCart(pro);
                          // widget.callback(true);
                          Navigator.of(context).pop();
                        },
                        child: customButton("Update Cart",
                            width: size.width / 2.2, fontsize: 14)),
                    InkWell(
                        onTap: () {
                          cartController.deleteItemByName(widget.product);

                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: customText("REMOVE ITEM",
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )),
                  ],
                );
              } else {
                return InkWell(
                    onTap: () {
                      ProductModel pro = widget.product!;
                      pro.quantity = qty;
                      cartController.addToCart(pro);
                      // widget.callback(true);
                      Navigator.of(context).pop();
                    },
                    child: customButton("Add to Cart", width: size.width / 2));
              }
              // }) customButton(
              //     widget.product.quantity == null
              //         ? "Add To Cart"
              //         : "Update Cart",
              //     width: size.width / 2)
            })
          ],
        ),
      ),
    );
  }
}
