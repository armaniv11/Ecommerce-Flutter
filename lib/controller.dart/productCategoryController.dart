import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dns/app_constants.dart';
import 'package:dns/functions/database.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/screens/gallery/product_categories.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProductCategoryController extends GetxController {
  List<ProductModel> gadgets = <ProductModel>[].obs;
  List<ProductModel> clothes = <ProductModel>[].obs;
  List<ProductModel> beauty = <ProductModel>[].obs;
  List<ProductModel> home = <ProductModel>[].obs;

  Map<String, dynamic> subCategoryList = {};

  int get countGadgets => gadgets.length;
  int get countClothes => clothes.length;
  int get countBeauty => beauty.length;
  int get countHome => home.length;

  DatabaseService databaseService = DatabaseService();
  // double get cartPrice =>
  //     cartItems.fold(0, (sum, element) => sum + element.price!);

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadSubCategory();
    // products = await getData();
    // rentedProducts = await getRentedProducts();
  }

  loadSubCategory() async {
    print("printing subc");
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('SubCategory')
        .doc('subcategory')
        .get();
    subCategoryList = docSnapshot.data() as Map<String, dynamic>;
    print(subCategoryList);
  }

  removeSubCategory(cat, subcat) async {
    List subcateg = subCategoryList[cat];
    subcateg.removeWhere((item) => item == subcat);
    subCategoryList[cat] = subcateg;
    print("printing from remvoe tosub cate");
    await databaseService.deleteSubCategory(
        category: cat, subcategory: subcateg);

    print(subCategoryList);
  }

  addToSubCategory(cat, subcat) async {
    List subcateg = subCategoryList[cat];
    subcateg.removeWhere((item) => item == subcat);
    subcateg.add(subcat);
    subCategoryList[cat] = subcateg;
    print("printing from add tosub cate");
    print(subCategoryList);
  }

  Future<List<ProductModel>> setBeauty({required category}) async {
    beauty = await getData(categoryname: category);
    return beauty;
  }

  Future<List<ProductModel>> setHome({required category}) async {
    home = await getData(categoryname: category);
    return home;
  }

  Future<List<ProductModel>> setGadget({required category}) async {
    gadgets = await getData(categoryname: category);
    return gadgets;
  }

  Future<List<ProductModel>> setClothes({required category}) async {
    clothes = await getData(categoryname: category);
    return clothes;
  }

  Future<List<ProductModel>> getData({required String? categoryname}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('category', isEqualTo: categoryname)
        .get();
    List<ProductModel> catInfo = querySnapshot.docs
        .map((m) => ProductModel.fromJson(m.data() as Map<String, dynamic>))
        .toList();
    return catInfo;
  }

  // Future<List<ProductModel>> filterByCategory(String catname) async {
  //   print("$catname categoryname");
  //   List<ProductModel> pro = <ProductModel>[];
  //   if (catname == AppConstants.categoryGadget) {
  //     print("in if");
  //     print(gadgets.length);
  //     pro = gadgets.take(6).toList();
  //     pro.forEach((element) {
  //       print(element.name);
  //     });
  //     return pro;
  //   } else if (catname == AppConstants.categoryClothes)
  //     return clothes.take(6).toList();
  //   else
  //     return [];
  // }

  Future<List<ProductModel>> checkAndLoadProducts(String? cat) async {
    if (cat == AppConstants.categoryClothes) {
      print("if running");
      if (countClothes == 0) {
        return await setClothes(category: cat);
      } else
        return clothes;
    } else if (cat == AppConstants.categoryGadget) {
      print("else running");
      if (countGadgets == 0) {
        return await setGadget(category: cat);
      } else
        return gadgets;
    } else if (cat == AppConstants.categoryBeauty) {
      print("else running");
      if (countBeauty == 0) {
        return await productCategoryController.setBeauty(category: cat);
      } else
        return beauty;
    } else
      return <ProductModel>[];
  }
}
