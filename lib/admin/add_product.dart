import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dns/app_properties.dart';
import 'package:dns/custom_classes/custom_classes.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/functions/database.dart';
import 'package:dns/models/productmodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:random_string/random_string.dart';

import '../custom_background.dart';

class AddProduct extends StatefulWidget {
  final String? productId;
  const AddProduct({Key? key, this.productId = ''}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController productController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController rentDepositController = TextEditingController();
  TextEditingController deliveryChargeController = TextEditingController();
  TextEditingController maxOrderController = TextEditingController();
  TextEditingController inStockController = TextEditingController(text: "1");

  String? _selectedCategory = '';
  String? _selectedCare = '';
  String? _selectedGST = '0%';
  String? _selectedUOM = "Pcs";
  String labelText = 'Add Product';
  String? netImage = '';

  List<String> categoryMenu = ['', 'Gadget', 'Clothes', 'Beauty'];
  List<String> productAudience = ['', 'Male', 'Female', 'Kids', 'All'];

  List<String> careMenu = [
    '',
    'Do not dry clean',
    'Dry clean only',
    'Do not bleach',
    'Hand wash',
    'Wash cold',
    'Wash warm'
  ];

  List<String> uomMenu = [
    'Pcs',
    'Kg',
    'Dozen',
    'Pound',
  ];

  List<String> gstMenu = [
    '0%',
    '5%',
    '8%',
    '12%',
    '18%',
    '28%',
  ];

  File? productImage1;
  bool isFeatured = false;
  bool isLoading = false;

  DatabaseService databaseService = DatabaseService();
  ImagePicker picker = ImagePicker();

  getImage() async {
    await Future.delayed(Duration(milliseconds: 500));
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
    // setState(() {
    if (pickedFile != null) {
      File img = File(pickedFile.path);
      return img;
    }
  }

  final _formKey = GlobalKey<FormState>();

  updateProduct(imgalias) async {
    String? imgUrl = netImage;
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      if (productImage1 != null) {
        final storageReference =
            FirebaseStorage.instance.ref().child("products/$imgalias");

        final uploadTask = storageReference.putFile(productImage1!);
        final downloadUrl = await uploadTask.whenComplete(() => null);
        imgUrl = await downloadUrl.ref.getDownloadURL();
      }

      salePriceController.text.isEmpty || salePriceController.text == '0'
          ? salePriceController.text = priceController.text
          : null;

      await databaseService
          .updateProduct(
              productPic: imgUrl,
              productName: productController.text,
              price: double.tryParse(priceController.text) ?? 0.0,
              salePrice: double.tryParse(salePriceController.text) ?? 0.0,
              description: descriptionController.text,
              care: _selectedCare,
              category: _selectedCategory,
              isFeatured: isFeatured,
              onrent: isRentable,
              rentamt: double.tryParse(rentController.text) ?? 0.0,
              rentdeposit: double.tryParse(rentDepositController.text) ?? 0.0,
              cod: isCOD,
              deliveryCharge:
                  double.tryParse(deliveryChargeController.text) ?? 0.0,
              replaceable: isReplacable,
              pid: widget.productId,
              audience: selectedAudience,
              taxPercent: _selectedGST,
              uom: _selectedUOM,
              maxSaleQty: int.tryParse(maxOrderController.text) ?? 1,
              stock: int.tryParse(maxOrderController.text) ?? 1)
          .then((value) {
        return AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: true,
            title: 'Success!',
            desc: 'Product has been updated successfully !',
            btnOkOnPress: () {
              debugPrint('OnClcik');
              Navigator.of(context).pop();
            },
            btnOkIcon: Icons.check_circle,
            onDissmissCallback: (type) {
              debugPrint('Dialog Dissmiss from callback $type');
            })
          ..show();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  saveProduct(imgname, imgalias) async {
    print(imgname);
    String imgUrl = '';
    if (_formKey.currentState!.validate()) {
      String pid = randomAlphaNumeric(6);
      setState(() {
        isLoading = true;
      });

      if (imgname != null) {
        final storageReference =
            FirebaseStorage.instance.ref().child("products/$imgalias");

        final uploadTask = storageReference.putFile(imgname);
        final downloadUrl = await uploadTask.whenComplete(() => null);
        imgUrl = await downloadUrl.ref.getDownloadURL();
      }
      salePriceController.text.isEmpty || salePriceController.text == '0'
          ? salePriceController.text = priceController.text
          : null;

      await databaseService
          .newProduct(
              productPic: imgUrl,
              productName: productController.text,
              price: double.tryParse(priceController.text) ?? 0.0,
              salePrice: double.tryParse(salePriceController.text) ?? 0.0,
              description: descriptionController.text,
              care: _selectedCare,
              category: _selectedCategory,
              isFeatured: isFeatured,
              onrent: isRentable,
              rentamt: double.tryParse(rentController.text) ?? 0.0,
              rentdeposit: double.tryParse(rentDepositController.text) ?? 0.0,
              cod: isCOD,
              deliveryCharge:
                  double.tryParse(deliveryChargeController.text) ?? 0.0,
              replaceable: isReplacable,
              pid: pid,
              audience: selectedAudience,
              taxPercent: _selectedGST,
              uom: _selectedUOM,
              maxSaleQty: int.tryParse(maxOrderController.text) ?? 1,
              stock: int.tryParse(maxOrderController.text) ?? 1)
          .then((value) {
        return AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: true,
            title: 'Success!',
            desc: 'Product has been added successfully !',
            btnOkOnPress: () {
              debugPrint('OnClcik');
              Navigator.of(context).pop();
            },
            btnOkIcon: Icons.check_circle,
            onDissmissCallback: (type) {
              debugPrint('Dialog Dissmiss from callback $type');
            })
          ..show();
      });
    }
    setState(() {
      isLoading = false;
    });

    // print(profilepic);
  }

  String selectedAudience = '';
  void selectCategory(String selected) {
    setState(() {
      _selectedCategory = selected;
    });
  }

  void selectCare(String selected) {
    setState(() {
      _selectedCare = selected;
    });
  }

  void selectUOM(String selected) {
    setState(() {
      _selectedUOM = selected;
    });
  }

  void selectAudience(String selected) {
    setState(() {
      selectedAudience = selected;
    });
  }

  void selectGST(String selected) {
    setState(() {
      _selectedGST = selected;
    });
  }

  void toggleIsFeatured(bool feat) {
    setState(() {
      isFeatured = feat;
    });
  }

  void toggleIsRent(bool feat) {
    setState(() {
      isRentable = feat;
    });
  }

  void toggleIsCOD(bool feat) {
    setState(() {
      isCOD = feat;
    });
  }

  void toggleIsReplacable(bool feat) {
    setState(() {
      isReplacable = feat;
    });
  }

  void toggleIsDeliveryFree(bool feat) {
    setState(() {
      isDeliveryFree = feat;
      if (isDeliveryFree) {
        deliveryChargeController.text = "0";
      }
    });
  }

  bool? isRentable = false;
  bool? isCOD = true;
  bool? isReplacable = true;
  bool isDeliveryFree = true;
  double deliveryCharge = 0;
  late ProductModel pro;

  @override
  void initState() {
    loadProduct();

    // TODO: implement initState
    super.initState();
  }

  loadProduct() async {
    if (widget.productId != '') {
      labelText = 'Update Product';
      await databaseService.getInfo('Products', widget.productId).then((value) {
        pro = ProductModel.fromJson(value.data() as Map<String, dynamic>);
        print(pro.name);
        productController.text = pro.name!;
        priceController.text = pro.price.toString();
        salePriceController.text = pro.saleprice.toString();
        print(pro.taxPercent);
        setState(() {
          _selectedGST = pro.taxPercent;
          _selectedUOM = pro.uom ?? "Kg";
          maxOrderController.text =
              pro.maxSaleQty == null ? "2" : pro.maxSaleQty.toString();
          inStockController.text =
              pro.stock == null ? "2" : pro.stock.toString();
          descriptionController.text = pro.desc!;
          _selectedCare = pro.careInstructions ?? "";
          _selectedCategory = pro.category ?? "";
          selectedAudience = pro.selectedAudience ?? "";
          isFeatured = pro.isFeatured!;
          isRentable = pro.onRent;
          rentController.text =
              pro.rentAmount == null ? "" : pro.rentAmount.toString();
          rentDepositController.text =
              pro.rentDeposit == null ? "" : pro.rentDeposit.toString();
          isCOD = pro.cod;
          deliveryChargeController.text = pro.deliveryCharge.toString();
          deliveryChargeController.text == '0' ||
                  deliveryChargeController.text == '0.0'
              ? isDeliveryFree = true
              : isDeliveryFree = false;
          isReplacable = pro.isReplacable;
          netImage = pro.productpic;
          print(pro.selectedAudience);

          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(color: backgroundColor!.withOpacity(0.8)),
        child: Scaffold(
          // backgroundColor: Colors.pink.withOpacity(0.7),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(labelText),
            elevation: 0,
          ),
          body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    customTextFormField(
                        productController,
                        "Product Name",
                        Icon(
                          FontAwesomeIcons.rupeeSign,
                          size: 16,
                        ),
                        validationEnabled: true),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customTextFormField(
                            priceController,
                            "Price",
                            Icon(
                              FontAwesomeIcons.rupeeSign,
                              size: 16,
                            ),
                            inputtype: TextInputType.number,
                            width: width / 2,
                            validationEnabled: true),
                        customTextFormField(
                          salePriceController,
                          "Sale Price",
                          Icon(
                            FontAwesomeIcons.rupeeSign,
                            size: 16,
                          ),
                          inputtype: TextInputType.number,
                          width: width / 2,
                        ),
                      ],
                    ),
                    CustomDropDown(
                        heading: "GST (Included in Sale Price / Price)",
                        items: gstMenu,
                        selected: _selectedGST,
                        callBack: selectGST),
                    CustomDropDown(
                        heading: "Product Unit of Measurement",
                        items: uomMenu,
                        selected: _selectedUOM,
                        callBack: selectUOM),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customTextFormField(
                            maxOrderController, "Max Order Qty.", null,
                            inputtype: TextInputType.number,
                            width: width / 2,
                            suffixText: _selectedUOM!),
                        customTextFormField(inStockController, "In Stock", null,
                            inputtype: TextInputType.number,
                            width: width / 2,
                            suffixText: _selectedUOM!),
                      ],
                    ),

                    customTextFormField(
                      descriptionController,
                      "Product Description",
                      Icon(
                        FontAwesomeIcons.info,
                        size: 16,
                      ),
                    ),
                    // careDropDown("Wash / Care Instructions"),
                    CustomDropDown(
                        heading: "Wash / Care Instructions",
                        items: careMenu,
                        callBack: selectCare,
                        selected: _selectedCare),
                    // categoryDropDown("Product Category"),
                    CustomDropDown(
                        heading: "Product Category",
                        items: categoryMenu,
                        callBack: selectCategory,
                        selected: _selectedCategory),
                    CustomDropDown(
                        heading: "Product Audience",
                        items: productAudience,
                        selected: selectedAudience,
                        callBack: selectAudience),
                    CustomCheckBox(
                      text: "Is Featured",
                      option: isFeatured,
                      callBack: toggleIsFeatured,
                    ),
                    CustomCheckBox(
                      text: "Available On rent !",
                      option: isRentable,
                      callBack: toggleIsRent,
                    ),
                    isRentable!
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customTextFormField(
                                  rentController,
                                  "Rent Amount",
                                  Icon(
                                    FontAwesomeIcons.rupeeSign,
                                    size: 16,
                                  ),
                                  inputtype: TextInputType.number,
                                  width: width / 2),
                              customTextFormField(
                                  rentDepositController,
                                  "Security Deposit",
                                  Icon(
                                    FontAwesomeIcons.rupeeSign,
                                    size: 16,
                                  ),
                                  inputtype: TextInputType.number,
                                  width: width / 2),
                            ],
                          )
                        : Container(),
                    CustomCheckBox(
                      text: "Cash On Delivery !",
                      option: isCOD,
                      callBack: toggleIsCOD,
                    ),
                    CustomCheckBox(
                      text: "Is Delivery Free !",
                      option: isDeliveryFree,
                      callBack: toggleIsDeliveryFree,
                    ),
                    !isDeliveryFree
                        ? customTextFormField(
                            deliveryChargeController,
                            "Delivery Charge",
                            Icon(FontAwesomeIcons.rupeeSign, size: 16))
                        : Container(),
                    CustomCheckBox(
                      text: "Is Replaceable !",
                      option: isReplacable,
                      callBack: toggleIsReplacable,
                    ),
                    InkWell(
                        onTap: () async {
                          productImage1 = await getImage();
                          setState(() {});
                        },
                        child: customButton("Select Product Image")),
                    imgColumn(
                        productImage1, netImage, "Asd", 250.00, width - 10),
                    InkWell(
                        onTap: () {
                          if (widget.productId == '')
                            saveProduct(productImage1, productController.text);
                          else
                            updateProduct(productController.text);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: saveButton(labelText),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
