import 'package:dns/admin/add_banner.dart';
import 'package:dns/admin/add_product.dart';
import 'package:dns/admin/all_orders.dart';
import 'package:dns/admin/all_products.dart';
import 'package:dns/admin/all_subcategory.dart';
import 'package:dns/app_constants.dart';
import 'package:dns/screens/auth/register_page_phone.dart';
import 'package:dns/screens/profile/add_profile.dart';
import 'package:dns/screens/rating/rating_dialog.dart';
import 'package:dns/screens/shop/myorders.dart';
import 'package:dns/screens/shop/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SideBar extends StatefulWidget {
  SideBar({Key? key});

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  String role = 'admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: widget.key,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.centerLeft,
              // rgb(45, 42, 79)
              colors: [
                Color.fromRGBO(47, 48, 68, 1),
                Color.fromRGBO(47, 48, 68, 1)
              ]),
        ),
        child: Column(
          children: <Widget>[
            // SizedBox(
            //   height: 60,
            // ),

            Padding(
              padding: const EdgeInsets.only(left: 10, top: 40, bottom: 20),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // padding: EdgeInsets.zero,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                            // color:Colors.black,
                            // border: Border.all(color:),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60, left: 16),
                          child: Row(children: <Widget>[
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/user.png")),
                                  color: Colors.blue,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    GetStorage().read(
                                            GetStorageConstants.signInName) ??
                                        "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.pink[100])),
                                SizedBox(
                                  height: 2,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Profile()));
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.yellow[100]),
                                      ),
                                      Icon(
                                        Icons.edit,
                                        color: Colors.yellow,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ]),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.pink[900],
                        thickness: 6,
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),

                      role == 'teacher' || role == 'admin'
                          ? ListTile(
                              dense: true,
                              leading: Icon(Icons.bakery_dining_outlined,
                                  color: Colors.grey[50]),
                              title: Text(
                                'Add Banner',
                                style: TextStyle(color: Colors.grey[50]),
                              ),
                              onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddBanner()))
                                  })
                          : Container(),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),

                      role == 'teacher' || role == 'admin'
                          ? ListTile(
                              dense: true,
                              leading: Icon(Icons.add, color: Colors.grey[50]),
                              title: Text(
                                'Add Product',
                                style: TextStyle(color: Colors.grey[50]),
                              ),
                              onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddProduct()))
                                  })
                          : Container(),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      role == 'teacher' || role == 'admin'
                          ? ListTile(
                              dense: true,
                              leading: Icon(Icons.add, color: Colors.grey[50]),
                              title: Text(
                                'Sub-Categories',
                                style: TextStyle(color: Colors.grey[50]),
                              ),
                              onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AllSubCategory()))
                                  })
                          : Container(),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),

                      role == 'teacher' || role == 'admin'
                          ? ListTile(
                              dense: true,
                              leading: Icon(Icons.add, color: Colors.grey[50]),
                              title: Text(
                                'All Products',
                                style: TextStyle(color: Colors.grey[50]),
                              ),
                              onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AllProducts()))
                                  })
                          : Container(),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      role == 'teacher' || role == 'admin'
                          ? ListTile(
                              dense: true,
                              leading:
                                  Icon(Icons.view_list, color: Colors.grey[50]),
                              title: Text(
                                'My Orders',
                                style: TextStyle(color: Colors.grey[50]),
                              ),
                              onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyOrders()))
                                  })
                          : Container(),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      role == 'teacher' || role == 'admin'
                          ? ListTile(
                              dense: true,
                              leading:
                                  Icon(Icons.favorite, color: Colors.grey[50]),
                              title: Text(
                                'Wishlist',
                                style: TextStyle(color: Colors.grey[50]),
                              ),
                              onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WishListCart()))
                                  })
                          : Container(),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      role == 'teacher' || role == 'admin'
                          ? ListTile(
                              dense: true,
                              leading: Icon(Icons.list, color: Colors.grey[50]),
                              title: Text(
                                'All Orders',
                                style: TextStyle(color: Colors.grey[50]),
                              ),
                              onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AllOrders()))
                                  })
                          : Container(),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      role == 'teacher' || role == 'admin'
                          ? ListTile(
                              dense: true,
                              leading: Icon(Icons.power_settings_new_outlined,
                                  color: Colors.grey[50]),
                              title: Text(
                                'Logout',
                                style: TextStyle(color: Colors.grey[50]),
                              ),
                              onTap: () {
                                GetStorage().write(
                                    GetStorageConstants.recentProducts, []);
                                GetStorage().erase().then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPagePhone()));

                                  // })
                                  // GetStorage()
                                  //     .write('isLoggedIn', false)
                                  //     .then((value) {
                                });
                              })
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              // decoration: BoxDecoration(
              //   color:Colors.black,
              //   borderRadius:BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20))
              // ),
              height: MediaQuery.of(context).size.height * 0.06,
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Made With ',
                      style: TextStyle(color: Colors.pink[100]),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    ),
                    // Image(
                    //     image: AssetImage('assets/images/emoji-heart-33.png'),
                    //     height: 12,
                    //     width: 12),
                    Text(' By ArMaNiV',
                        style: TextStyle(color: Colors.pink[100]))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
