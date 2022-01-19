import 'package:dns/app_properties.dart';
import 'package:dns/controller.dart/cartController.dart';
import 'package:dns/custom_classes/custom_classes.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/functions/database.dart';
import 'package:dns/models/category.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/models/reviewModel.dart';
import 'package:dns/models/subCategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../app_constants.dart';

class AddSubCategoryBottomSheet extends StatefulWidget {
  // final ValueChanged<bool> callback;

  @override
  _AddSubCategoryBottomSheetState createState() =>
      _AddSubCategoryBottomSheetState();
}

class _AddSubCategoryBottomSheetState extends State<AddSubCategoryBottomSheet> {
  final DatabaseService databaseService = DatabaseService();
  String _selectedCategory = AppConstants.categoryMisc;
  TextEditingController subCategoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void selectCategory(String selected) {
    setState(() {
      _selectedCategory = selected;
    });
  }

  saveSubCategory() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await databaseService.newSubCategory(
          category: _selectedCategory,
          subcategory: [subCategoryController.text]).then((value) {
        customToast("Sub category added successfully!!");
        Navigator.pop(
            context,
            SubCategoryModel(
                category: _selectedCategory,
                subCategory: subCategoryController.text));
      });
      // print(profilepic);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.only(top: 12),
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.pink[900],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24), topLeft: Radius.circular(24))),
          child:
              // ListView(
              //   children: <Widget>[
              Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "New Sub Category",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(
                  thickness: 6,
                ),
                CustomDropDown(
                    heading: "Product Category",
                    color: Colors.grey,
                    items: AppConstants.categoryListString,
                    callBack: selectCategory,
                    selected: _selectedCategory),
                customTextFormField(
                    subCategoryController, "Sub Category Name", null,
                    headingColor: Colors.grey, validationEnabled: true),
                InkWell(
                    onTap: () {
                      saveSubCategory();
                    },
                    child: customButton("Add"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
