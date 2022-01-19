import 'package:dns/admin/components/addSubcategoryBottomSheet.dart';
import 'package:dns/admin/components/each_tag.dart';
import 'package:dns/app_constants.dart';
import 'package:dns/controller.dart/cartController.dart';
import 'package:dns/controller.dart/productCategoryController.dart';
import 'package:dns/controller.dart/productController.dart';
import 'package:dns/models/category.dart';
import 'package:dns/models/product.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/models/subCategoryModel.dart';
import 'package:dns/screens/gallery/product_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_product.dart';

class AllSubCategory extends StatefulWidget {
  const AllSubCategory({Key? key}) : super(key: key);

  @override
  _AllSubCategoryState createState() => _AllSubCategoryState();
}

class _AllSubCategoryState extends State<AllSubCategory> {
  final ProductCategoryController productCategoryController = Get.find();
  List<SubCategoryModel> results = <SubCategoryModel>[];

  @override
  void initState() {
    loadSubCat();
    // TODO: implement initState
    super.initState();
  }

  loadSubCat() async {
    productCategoryController.subCategoryList.forEach((key, value) {
      value.forEach((ele) {
        results.add(SubCategoryModel(category: key, subCategory: ele));
      });
    });
    results.forEach((element) {
      print(element.subCategory);
    });
  }

  final GlobalKey<AnimatedListState> _key = GlobalKey();
  void _addItem(SubCategoryModel modal) {
    results.insert(0, modal);
    _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
    productCategoryController.addToSubCategory(
        modal.category, modal.subCategory);
  }

  // Remove an item
  // This is trigger when the trash icon associated with an item is tapped
  void _removeItem(int index, SubCategoryModel result) {
    _key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: const Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.red,
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text("Removed",
                style: TextStyle(fontSize: 24, color: Colors.white)),
          ),
        ),
      );
    }, duration: const Duration(seconds: 1));
    productCategoryController.removeSubCategory(
        result.category, result.subCategory);
    results.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[900],
          title: Text("Sub Categories"),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    // isDismissible: true,
                    context: context,
                    builder: (context) {
                      return AddSubCategoryBottomSheet(

                          // callback: changeCart,
                          );
                    },
                  ).then((value) {
                    if (value != null) _addItem(value);
                  });
                },
                icon: Icon(Icons.add))
          ],
          // flexibleSpace: Container(
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(tileMode: TileMode.mirror,
          //           // begin: Alignment.topLeft,
          //           // end: Alignment.bottomRight,
          //           colors: <Color>[Colors.pink[900]!, Colors.pink])),
          // ),
        ),
        backgroundColor: Colors.grey[100],
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : AnimatedList(
                key: _key,
                initialItemCount: results.length,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                itemBuilder: (_, index, animation) {
                  return SizeTransition(
                    key: UniqueKey(),
                    sizeFactor: animation,
                    child: Card(
                      margin: const EdgeInsets.all(4),
                      elevation: 10,
                      color: Colors.orange,
                      child: ListTile(
                        leading: CircleAvatar(child: Text("${index + 1}")),
                        contentPadding: const EdgeInsets.all(6),
                        subtitle: Text(results[index].subCategory!,
                            style: const TextStyle(fontSize: 24)),
                        title: Text(results[index].category!,
                            style: const TextStyle(fontSize: 16)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeItem(index, results[index]),
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
