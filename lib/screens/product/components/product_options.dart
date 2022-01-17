import 'package:dns/app_properties.dart';
import 'package:dns/models/product.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/screens/shop/check_out_page.dart';
import 'package:flutter/material.dart';

import 'shop_bottomSheet.dart';

class ProductOption extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ProductModel? product;
  const ProductOption(
    this.scaffoldKey, {
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 2.5,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height / 2.5,
            width: size.width * 0.9,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(product!.productpic!),
                    fit: BoxFit.fill),
                color: Colors.yellow[800],
                borderRadius: BorderRadius.circular(12)),
          )

          // Image.network(
          //   product.productpic!,
          //   height: size.height / 3,
          //   width: size.width * 0.9,
          // ),
          // Positioned(
          //   right: 0.0,
          //   child: Container(
          //     height: 180,
          //     width: 300,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: <Widget>[
          //         Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
          //           child: Text(product.name!,
          //               textAlign: TextAlign.right,
          //               style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.white,
          //                   shadows: shadow)),
          //         ),
          //         InkWell(
          //           onTap: () async {
          //             Navigator.of(context).push(
          //                 MaterialPageRoute(builder: (_) => CheckOutPage()));
          //           },
          //           child: Container(
          //             width: MediaQuery.of(context).size.width / 2.5,
          //             decoration: BoxDecoration(
          //                 color: Colors.red,
          //                 gradient: mainButton,
          //                 borderRadius: BorderRadius.only(
          //                     topLeft: Radius.circular(10.0),
          //                     bottomLeft: Radius.circular(10.0))),
          //             padding: EdgeInsets.symmetric(vertical: 16.0),
          //             child: Center(
          //               child: Text(
          //                 'Buy Now',
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         InkWell(
          //           onTap: () {
          //             scaffoldKey.currentState!.showBottomSheet((context) {
          //               return ShopBottomSheet();
          //             });
          //           },
          //           child: Container(
          //             width: MediaQuery.of(context).size.width / 2.5,
          //             decoration: BoxDecoration(
          //                 color: Colors.red,
          //                 gradient: mainButton,
          //                 borderRadius: BorderRadius.only(
          //                     topLeft: Radius.circular(10.0),
          //                     bottomLeft: Radius.circular(10.0))),
          //             padding: EdgeInsets.symmetric(vertical: 16.0),
          //             child: Center(
          //               child: Text(
          //                 'Add to cart',
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
