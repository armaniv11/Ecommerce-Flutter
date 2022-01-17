import 'package:dns/app_properties.dart';
import 'package:dns/controller.dart/cartController.dart';
import 'package:dns/controller.dart/productCategoryController.dart';
import 'package:dns/controller.dart/productController.dart';
import 'package:dns/controller.dart/recentController.dart';
import 'package:dns/screens/auth/register_page_phone.dart';
import 'package:dns/screens/auth/welcome_back_page.dart';
import 'package:dns/screens/main/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;
  // FirebaseAuth _auth = FirebaseAuth.instance;
  final shoppingCOntroller = Get.put(ShoppingController());

  @override
  void initState() {
    super.initState();
    Get.put(CartController());
    Get.put(ProductCategoryController());
    Get.put(RecentController());

    controller = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    bool checklogin = GetStorage().read('isLoggedIn') ?? false;
    if (checklogin) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
    } else
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => RegisterPagePhone()));
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(color: transparentYellow),
        child: SafeArea(
          child: new Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Opacity(
                      opacity: opacity.value,
                      child: new Image.asset('assets/logo.png')),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: RichText(
                //     text: TextSpan(
                //         style: TextStyle(color: Colors.black),
                //         children: [
                //           TextSpan(text: 'Powered by '),
                //           TextSpan(
                //               text: 'int2.io',
                //               style: TextStyle(fontWeight: FontWeight.bold))
                //         ]),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
