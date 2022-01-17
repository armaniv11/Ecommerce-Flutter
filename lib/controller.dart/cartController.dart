import 'package:dns/models/product.dart';
import 'package:dns/models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  var cartItems = <ProductModel>[].obs;
  // double cartTaxes = 0.obs as double;
  // double cartBeforeTax = 0.obs as double;

  int get countitems => cartItems.length;

  double get cartPrice => cartItems.fold(
      0,
      (sum, element) =>
          sum +
          (element.saleprice! * element.quantity!) +
          element.deliveryCharge);

  double get cartShipping =>
      cartItems.fold(0, (sum, element) => sum + (element.deliveryCharge));

  String get cartBeforeTax {
    double asd = cartItems.fold(
        0,
        (sum, element) =>
            sum +
            (element.saleprice! * element.quantity!) +
            element.deliveryCharge);
    return (asd - getCartTax).toStringAsFixed(2);
  }

  @override
  void onInit() {
    List wishListRead = GetStorage().read('cart') ?? [];
    if (wishListRead.isNotEmpty) {
      cartItems =
          wishListRead.map((e) => ProductModel.fromJson(e)).toList().obs;
    }
    ever(cartItems, (dynamic _) {
      GetStorage().write('cart', cartItems.toList());
    });
    // TODO: implement onInit
    super.onInit();
  }

  double get getCartTax {
    // int i = 0;
    double? tax = 0;
    double taxrs = 0;
    double cartTaxes = 0;
    String result;
    for (final element in cartItems) {
      if (element.saleprice! > 1) {
        if (element.taxPercent != null) {
          result =
              element.taxPercent!.substring(0, element.taxPercent!.length - 1);
          tax = double.tryParse(result);
          taxrs = tax! * element.saleprice! / 100;
          taxrs = taxrs * element.quantity!;
          cartTaxes = cartTaxes + taxrs;
          print(element.saleprice);
          print(" In If $taxrs $cartTaxes");
        }
      } else {
        if (element.taxPercent != null) {
          result =
              element.taxPercent!.substring(0, element.taxPercent!.length - 1);
          tax = double.tryParse(result);
          taxrs = tax! * element.price! / 100;
          cartTaxes = cartTaxes + taxrs;
        }
      }
    }
    return cartTaxes;
  }

  addToCart(ProductModel product) {
    String msg = "${product.name} added to Cart !";
    int i = 0;
    for (final element in cartItems) {
      print(element);
      if (element.pid == product.pid) {
        cartItems.removeAt(i);
        msg = "${product.name} has been updated in the Cart !";
        break;
      }
      i = i + 1;
    }
    //   cartItems.add(items);
    cartItems.add(product);
    print("Cart Length: ${cartItems.length}");
    Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green[900],
            textColor: Colors.white,
            fontSize: 14.0)
        .then((value) {
      return cartItems;
    });
  }
  // int get totalamount => () {};

  // int get totamt {
  //   int initialamt = 0;
  //   int initialamt2 = 0;
  //   for (final element in cartItems) {
  //     // print(int.parse(element['quantity']));
  //     print(element['quantity']);
  //     print(element['price']);
  //     int qty = element['quantity'];
  //     initialamt2 = int.parse(element['price']) * qty;
  //     print(initialamt2);
  //     initialamt = initialamt + initialamt2;
  //   }
  //   return initialamt;
  // }

  clearCart() {
    cartItems.clear();
  }

  checkInCart(ProductModel? product) {
    bool match = false;
    for (ProductModel element in cartItems) {
      if (element.pid == product!.pid) {
        match = true;
        return match;
        // return true;
      }
    }
    return match;
  }

  deleteItemByName(ProductModel? product) {
    int i = 0;
    for (final element in cartItems) {
      print(element);
      if (element.pid == product!.pid) {
        cartItems.removeAt(i);
        break;
      }
      i++;
    }
    return cartItems;
  }

  deleteFromCart(int index, ProductModel product) {
    cartItems.removeAt(index);
    Fluttertoast.showToast(
        msg: "${product.name} has been removed from Cart !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green[900],
        textColor: Colors.white,
        fontSize: 14.0);
  }

  // deleteFromCart(String pid) {
  //   int i = 0;
  //   for (final element in cartItems) {
  //     print(element['name']);
  //     print(pid);
  //     // print(element);
  //     if (element['name'] == pid) {
  //       cartItems.removeAt(i);
  //       break;
  //     }
  //     i++;
  //   }
  // }

}
