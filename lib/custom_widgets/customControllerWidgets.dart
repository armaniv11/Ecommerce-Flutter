import 'package:dns/controller.dart/productController.dart';
import 'package:dns/controller.dart/recentController.dart';
import 'package:dns/custom_classes/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget gridviewRecent = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: GetBuilder<RecentController>(builder: (controller) {
      print("printing getbuilder");
      print(controller.recentProducts.length);
      return controller.recentProducts.length > 0 &&
              controller.recentProducts.length < 7
          ? GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // childAspectRatio: 1 / 1,
                  mainAxisExtent: 270,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10),
              itemCount: controller.recentProducts.length,
              itemBuilder: (BuildContext ctx, index) {
                return ProductGrid(product: controller.recentProducts[index]);
              })
          : Container();
    }));

Widget gridviewOnly(controller, String controllerFor) {
  var rproducts;
  if (controllerFor == 'TOPSELLERS') {
    rproducts = controller.products;
  } else if (controllerFor == 'RENTED') {
    rproducts = controller.rentedProducts;
  }

  return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // childAspectRatio: 1 / 1,
          mainAxisExtent: 270,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10),
      itemCount: rproducts.length,
      itemBuilder: (BuildContext ctx, index) {
        return ProductGrid(product: rproducts[index]);
      });
}

Widget gridviewTopRented = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: GetBuilder<ShoppingController>(builder: (controller) {
      return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // childAspectRatio: 1 / 1,
              mainAxisExtent: 270,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10),
          itemCount: controller.products.length,
          itemBuilder: (BuildContext ctx, index) {
            return ProductGrid(product: controller.products[index]);
          });
    }));
