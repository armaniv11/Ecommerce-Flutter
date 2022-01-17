import 'package:dns/models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WishListController extends GetxController {
  var wishlist = [].obs;

  int get countitems => wishlist.length;
  double get wishListPrice => wishlist.fold(
      0,
      (sum, element) =>
          sum +
          (element.saleprice * element.quantity) +
          element.deliveryCharge);

  @override
  void onInit() {
    List wishListRead = GetStorage().read('wishlist') ?? [];
    if (wishListRead.isNotEmpty) {
      wishlist = wishListRead.map((e) => ProductModel.fromJson(e)).toList().obs;
    }
    ever(wishlist, (dynamic _) {
      GetStorage().write('wishlist', wishlist.toList());
    });
    // TODO: implement onInit
    super.onInit();
  }

  addToWishList(ProductModel product) {
    if (product.quantity == null) {
      product.quantity = 1;
    }
    int i = 0;
    for (final element in wishlist) {
      print(element);
      if (element.pid == product.pid) {
        wishlist.removeAt(i);
        return Fluttertoast.showToast(
            msg: "${product.name} removed from Wishlist !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green[900],
            textColor: Colors.white,
            fontSize: 14.0);
        // break;
      }

      i = i + 1;
    }
    wishlist.add(product);
    print("Cart Length: ${wishlist.length}");
    Fluttertoast.showToast(
            msg: "${product.name} added to Wishlist !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green[900],
            textColor: Colors.white,
            fontSize: 14.0)
        .then((value) {
      return wishlist;
    });
  }

  deleteFromWishlist(int index, ProductModel product) {
    wishlist.removeAt(index);
    Fluttertoast.showToast(
        msg: "${product.name} has been removed from Wishlist !!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green[900],
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
