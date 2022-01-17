import 'package:dns/controller.dart/wishlistController.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/screens/product/view_product_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductGrid extends StatefulWidget {
  final ProductModel? product;
  const ProductGrid({Key? key, required this.product}) : super(key: key);

  @override
  _ProductGridState createState() => _ProductGridState();
}

final WishListController wishListController = Get.find();

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              print(widget.product!.category);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ViewProductPage(
                        product: widget.product,
                      )));
            },
            child: Container(
              height: 170,
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          wishListController.addToWishList(widget.product!);
                          print("added to wishlist");
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FaIcon(
                                FontAwesomeIcons.heart,
                                color: Colors.pink,
                                size: 16,
                              ),
                            )),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.share,
                              size: 16,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.product!.productpic!),
                      fit: BoxFit.fill),
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: customText(widget.product!.name!,
                size: 12, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: iconWithText(FontAwesomeIcons.rupeeSign, 10.0,
                    widget.product!.saleprice.toString(),
                    color: Colors.pink),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: iconWithText(FontAwesomeIcons.rupeeSign, 8.0,
                    widget.product!.price.toString(),
                    color: Colors.grey,
                    fontsize: 10,
                    textDecoration: TextDecoration.lineThrough),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textWithIcon(Icons.star, 12.0, "${widget.product!.rating * 5}",
                    color: Colors.white),
                widget.product!.deliveryCharge <= 1
                    ? Container()
                    : containerText("Free Delivery!!"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
