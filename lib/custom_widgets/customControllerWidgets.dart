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

Widget gridviewTopSellers = Padding(
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
