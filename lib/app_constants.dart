import 'package:flutter/material.dart';

import 'models/category.dart';

class AppConstants {
  static String categoryClothes = 'Clothes';
  static String categoryGadget = 'Gadget';
  static String categoryBeauty = 'Beauty';
  static String categoryHome = 'Home';
  static String categoryMisc = 'Miscellaneous';

  static String cart = 'CART';
  static String wishlist = 'WISHLIST';
  static List<Category> categoryList = [
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'Gadget',
      'assets/gadget.jpg',
    ),
    Category(
      Color(0xffF749A2),
      Color(0xffFF7375),
      'Clothes',
      'assets/fashion.jpg',
    ),
    Category(
      Color(0xffAF2D68),
      Color(0xff632376),
      'Home',
      'assets/home.jpg',
    ),
    Category(
      Color(0xff36E892),
      Color(0xff33B2B9),
      'Beauty',
      'assets/beauty.jpg',
    ),
    Category(
      Color(0xffF123C4),
      Color(0xff668CEA),
      'Appliances',
      'assets/jeans_5.png',
    ),
  ];
// category with all option added
  static List<Category> categoryAllList = [
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'All',
      'assets/gadget.jpg',
    ),
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'Gadget',
      'assets/gadget.jpg',
    ),
    Category(
      Color(0xffF749A2),
      Color(0xffFF7375),
      'Clothes',
      'assets/fashion.jpg',
    ),
    Category(
      Color(0xffAF2D68),
      Color(0xff632376),
      'Home',
      'assets/home.jpg',
    ),
    Category(
      Color(0xff36E892),
      Color(0xff33B2B9),
      'Beauty',
      'assets/beauty.jpg',
    ),
    Category(
      Color(0xffF123C4),
      Color(0xff668CEA),
      'Appliances',
      'assets/jeans_5.png',
    ),
  ];
}

class GetStorageConstants {
  static String recentProducts = 'recent';
  static String signInMob = 'mob';
  static String signInName = 'username';
  static String allProducts = 'allproducts';
}
