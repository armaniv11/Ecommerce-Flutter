import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dns/controller.dart/cartController.dart';
import 'package:dns/screens/profile/add_profile.dart';
import 'package:dns/screens/shop/cart.dart';
import 'package:dns/screens/shop/myorders.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  final VoidCallback? indexChanged;
  const BottomNavBar({Key? key, required this.indexChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _bottomNavIndex = 0;

    return AnimatedBottomNavigationBar(
      backgroundColor: Colors.pink[900],
      icons: [
        Icons.menu,
        Icons.account_box,
        Icons.insert_emoticon_outlined,
        Icons.feedback
      ],
      inactiveColor: Colors.white,
      activeColor: Colors.yellow,
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      onTap: (index) async {
        if (index == 0) {
          print(index);
          this.indexChanged!();
        } else if (index == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile()));
          print(index);
        } else if (index == 2) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyOrders()));

          print(index);
        } else if (index == 3) {
          print(index);
        }
      },
      //other params
    );
  }
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      width: 60.0,
      child: FittedBox(
        child: GetX<CartController>(builder: (controller) {
          return controller.countitems > 0
              ? Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      child: FloatingActionButton(
                        backgroundColor: Colors.pink[900],
                        child: Icon(Icons.shopping_cart),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShoppingCart()));
                          // makeorderRequest();
                          // Navigator.push(
                          //     context, MaterialPageRoute(builder: (context) => Cart()));
                        },
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 7,
                      child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.pink[900]!),
                              color: Colors.white,
                              shape: BoxShape.circle),
                          child: Text(
                            controller.countitems.toString(),
                            style: TextStyle(
                                color: Colors.pink[900],
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                )
              : Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white)),
                  child: FloatingActionButton(
                    backgroundColor: Colors.pink[900],
                    child: Icon(Icons.shopping_cart),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShoppingCart()));
                      // makeorderRequest();
                      // Navigator.push(
                      //     context, MaterialPageRoute(builder: (context) => Cart()));
                    },
                  ),
                );
        }),
      ),
    );
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  }
}
