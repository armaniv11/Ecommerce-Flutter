import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dns/models/productmodel.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';

class ShoppingController extends GetxController {
  List<ProductModel> products = <ProductModel>[].obs;
  List<ProductModel> rentedProducts = <ProductModel>[].obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    products = await getData();
    rentedProducts = await getRentedProducts();
  }

  Future<List<ProductModel>> getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Products').get();
    return querySnapshot.docs
        .map((m) => ProductModel.fromJson(m.data() as Map<String, dynamic>))
        .toList();
    // return products;
  }

  Future<List<ProductModel>> getRentedProducts() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('onRent', isEqualTo: true)
        .get();
    return querySnapshot.docs
        .map((m) => ProductModel.fromJson(m.data() as Map<String, dynamic>))
        .toList();
    // return products;
  }

  Future<List<ProductModel>> filterByCategory(String catname) async {
    if (catname == 'All') return products;
    List<ProductModel> pro = <ProductModel>[];
    products.forEach((element) {
      element.category == catname ? pro.add(element) : null;
    });
    return pro;
  }

  Future<List<ProductModel>> filterByRentable({bool isRentable = true}) async {
    // if (catname == 'All') return products;
    List<ProductModel> pro = <ProductModel>[];
    rentedProducts.forEach((element) {
      element.onRent == isRentable ? pro.add(element) : null;
    });
    return pro;
  }
}
