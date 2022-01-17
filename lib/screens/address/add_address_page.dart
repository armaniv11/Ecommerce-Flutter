import 'package:dns/controller.dart/cartController.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/functions/database.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/screens/main/main_page.dart';
import 'package:dns/screens/select_card_page.dart';
import 'package:dns/screens/shop/confirm_order.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:random_string/random_string.dart';

import '../../app_properties.dart';
import 'address_form.dart';

class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobController = TextEditingController();

  TextEditingController pincodeController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  var profileInfo;
  DatabaseService databaseService = DatabaseService();
  final box = GetStorage();
  final CartController cartController = Get.find();
  bool isLoading = true;

  @override
  void initState() {
    checkProfile();
    // TODO: implement initState
    super.initState();
  }

  checkProfile() async {
    profileInfo = await databaseService.getInfo('Profile', box.read('mob'));
    mobController.text = box.read('mob') ?? "";
    if (profileInfo != null) {
      nameController.text = profileInfo['name'] ?? "";
      emailController.text = profileInfo['email'] ?? "";
      addressController.text = profileInfo['address'] ?? "";
      cityController.text = profileInfo['city'] ?? "";
      pincodeController.text = profileInfo['pincode'] ?? "";
      // networkImage = profileInfo['profilepic'] ?? "";
      // gender = profileInfo['gender'] == '' ? 'Male' : profileInfo['gender'];
    }
    setState(() {
      isLoading = false;
    });
  }

  Map<String?, dynamic> orders = {};

  saveOrder() async {
    setState(() {
      isLoading = true;
    });
    String pid = randomAlphaNumeric(6);
    final CartController cartItems = Get.find();
    List<ProductModel> pro = cartItems.cartItems;
    pro.forEach((element) {
      var pid = element.pid;
      var asd = element.toJson();
      asd['rating'] = 0;
      asd['quantity'] = 1;
      orders[pid] = asd;
    });
    print(orders);

    String address = addressController.text +
        ',' +
        cityController.text +
        ',' +
        pincodeController.text +
        ',' +
        stateController.text;
    // cartItems.cartItems
    await databaseService
        .saveOrderCombine(
            pid,
            orders,
            pid,
            cartItems.cartPrice,
            cartItems.cartPrice,
            0,
            0,
            '',
            'Ordered',
            address,
            box.read('mob'),
            0,
            nameController.text,
            box.read('mob'))
        .then((value) {
      box.write('cart', []);
      cartController.clearCart();
      Fluttertoast.showToast(
          msg: "Order has been placed successfully !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green[900],
          textColor: Colors.white,
          fontSize: 14.0);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget finishButton = InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => SelectCardPage())),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Finish",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        title: Text(
          'Shipping Address',
          style: const TextStyle(
              color: darkGrey,
              fontWeight: FontWeight.w500,
              fontFamily: "Montserrat",
              fontSize: 18.0),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (_, viewportConstraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Container(
                    padding: EdgeInsets.only(
                        // left: 6.0,
                        // right: 6.0,
                        bottom: MediaQuery.of(context).padding.bottom == 0
                            ? 10
                            : MediaQuery.of(context).padding.bottom),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10),
                                color: Colors.white,
                                elevation: 3,
                                child: SizedBox(
                                    height: 80,
                                    width: 160,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Image.asset(
                                                'assets/icons/address_home.png'),
                                          ),
                                          Text(
                                            'Add New Address',
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: darkGrey,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ))),
                            Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10),
                                color: yellow,
                                elevation: 3,
                                child: SizedBox(
                                    height: 80,
                                    width: 160,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Image.asset(
                                                'assets/icons/address_work.png',
                                                color: Colors.white,
                                                height: 20),
                                          ),
                                          Text(
                                            'Home Address',
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    )))
                          ],
                        ),
                        // AddAddressForm(),
                        customTextFormFieldWithoutHeading(
                            nameController, "Name", Icon(Icons.person)),
                        customTextFormFieldWithoutHeading(
                            mobController, "Mobile Number", Icon(Icons.phone),
                            inputtype: TextInputType.phone),
                        customTextFormFieldWithoutHeading(
                            emailController, "Email ID", Icon(Icons.email),
                            inputtype: TextInputType.emailAddress),
                        customTextFormFieldWithoutHeading(
                            addressController, "Address", Icon(Icons.map),
                            maxlines: 4),
                        customTextFormFieldWithoutHeading(
                            cityController, "City", Icon(Icons.map)),
                        customTextFormFieldWithoutHeading(pincodeController,
                            "Pincode", Icon(Icons.location_on)),
                        customTextFormFieldWithoutHeading(
                            stateController, "State", Icon(Icons.location_on)),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () {
                              saveOrder();
                              // ();
                              // String address = addressController.text +
                              //     ',' +
                              //     cityController.text +
                              //     ',' +
                              //     pincodeController.text +
                              //     ',' +
                              //     stateController.text;

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             ConfirmOrder(address: address)));
                            },
                            child: customButton("Make Payment",
                                color: Colors.white,
                                icon: Icons.arrow_forward)),
                        // Center(child: finishButton)
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
