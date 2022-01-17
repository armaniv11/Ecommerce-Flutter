import 'package:dns/app_constants.dart';
import 'package:dns/models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RecentController extends GetxController {
  var recentProducts = [].obs;

  int get countitems => recentProducts.length;
  // double get wishListPrice =>
  //     wishlist.fold(0, (sum, element) => sum + (element.price!));

  @override
  void onInit() {
    List recentRead =
        GetStorage().read(GetStorageConstants.recentProducts) ?? [];
    if (recentRead.isNotEmpty) {
      recentProducts = recentRead
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList()
          .obs;
    }
    ever(recentProducts, (dynamic _) {
      GetStorage()
          .write(GetStorageConstants.recentProducts, recentProducts.toList());
    });
    // TODO: implement onInit
    super.onInit();
  }

  addToRecentList(ProductModel? product) {
    bool isAdded = false;
    if (recentProducts.length <= 6) {
      if (product!.quantity == null) {
        product.quantity = 1;
      }
      int i = 0;
      for (final element in recentProducts) {
        if (element.pid == product.pid) {
          isAdded = true;
        }
      }
      if (!isAdded) recentProducts.add(product);
      return recentProducts;
    }
  }
}
