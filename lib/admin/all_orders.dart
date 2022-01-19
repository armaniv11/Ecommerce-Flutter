import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dns/admin/order_detail.dart';
import 'package:dns/app_constants.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/functions/database.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/models/reviewModel.dart';
import 'package:dns/screens/product/components/rating_bottomSheet.dart';
import 'package:dns/screens/product/components/rating_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import '../../app_properties.dart';
// import 'confirm_order.dart';

class AllOrders extends StatefulWidget {
  // const AllOrders({Key? key}) : super(key: key);

  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  DatabaseService databaseService = DatabaseService();
  final box = GetStorage();
  bool iSLoading = true;
  @override
  void initState() {
    loadOrder();
    // TODO: implement initState
    super.initState();
  }

  late var orders;
  late var allOrders;
  loadOrder() async {
    orders = await databaseService.getCollection('Orders');
    allOrders = orders;
    orders.docs.forEach((element) {
      print(element['cartTotal']);
    });
    setState(() {
      iSLoading = false;
    });
  }

  loadOrderWhere() async {
    print(AppConstants.orderOptions[selectedIndex]);
    orders = await databaseService.getCollectionWhere(
        'Orders', AppConstants.orderOptions[selectedIndex],
        wherequery: 'orderStatus');
    // allOrders = orders;
    print(orders.docs.length);
    orders.docs.forEach((element) {
      print(element['cartTotal']);
    });
    setState(() {
      iSLoading = false;
    });
  }

  Widget _buildSuggestionWidget() {
    return Wrap(alignment: WrapAlignment.start, children: techChips().toList());
  }

  int selectedIndex = 0;

  List<Widget> techChips() {
    List<Widget> chips = [];
    for (int i = 0; i < AppConstants.orderOptions.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: ChoiceChip(
          label: Text(AppConstants.orderOptions[i]),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.grey[400],
          shadowColor: Colors.yellow,
          selectedShadowColor: Colors.yellow,
          selectedColor: Colors.green,
          selected: selectedIndex == i,
          onSelected: (bool value) {
            setState(() {
              iSLoading = true;
            });
            selectedIndex = i;
            print("Selected Index is $selectedIndex");
            if (i == 0) {
              setState(() {
                orders = allOrders;
                iSLoading = false;
              });
            } else {
              loadOrderWhere();
            }
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.pink[900],
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "All Orders",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: iSLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    color: Colors.pink[900],
                    width: double.maxFinite,
                    child: _buildSuggestionWidget(),
                  ),
                  // Divider(
                  //   thickness: 10,
                  //   color: Colors.grey[400],
                  // ),
                  Expanded(
                    child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: orders.docs.length,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CartListMyOrder(
                            product: orders.docs[index],
                          );
                        }),
                  )
                ],
              ));
  }
}

class CartListMyOrder extends StatefulWidget {
  final product;
  CartListMyOrder({required this.product});

  @override
  _CartListMyOrderState createState() => _CartListMyOrderState();
}

class _CartListMyOrderState extends State<CartListMyOrder> {
  String? orderStatus = '';
  @override
  void initState() {
    orderStatus = widget.product['orderStatus'];

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(product['orders']);
    String deliveryDate = '';
    List asd = [];
    widget.product['orders'].forEach((k, v) {
      asd.add(v);
    });
    // print(asd);
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              customText("Order Details",
                  fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),
              RichText(
                text: TextSpan(
                  text: ' (Order Id: ',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                      fontFamily: 'Montserrat'),
                  children: <TextSpan>[
                    TextSpan(
                        text: widget.product['orderid'] + ')',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: Colors.grey[800])),
                  ],
                ),
              ),
              Spacer(),
              InkWell(
                  onTap: () async {
                    var as = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderDetails(
                                  products: asd,
                                  orderDetails: widget.product,
                                )));
                    setState(() {
                      if (as != null) {
                        orderStatus = as;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 22),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.blue[800],
                      size: 26,
                    ),
                  ))
            ],
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 4),
              child: RichText(
                text: TextSpan(
                  text: 'Ordered on ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: widget.product['createdat'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat')),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
              child: RichText(
                text: TextSpan(
                  text: 'Status ',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontFamily: 'Montserrat'),
                  children: <TextSpan>[
                    TextSpan(
                        text: orderStatus,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: Colors.grey[800])),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 4),
              child: RichText(
                text: TextSpan(
                  text: 'Order Total ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Rs. ${widget.product['orderTotal']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat')),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
              child: RichText(
                text: TextSpan(
                  text: 'Order by ',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontFamily: 'Montserrat'),
                  children: <TextSpan>[
                    TextSpan(
                        text: widget.product['signInMob'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: Colors.grey[800])),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Divider(
        //   thickness: 1.5,
        // ),
        // ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: asd.length,
        //     physics: NeverScrollableScrollPhysics(),
        //     itemBuilder: (ctx, index) {
        //       return CartProduct(
        //         order: asd[index],
        //         orderStatus: widget.product['orderStatus'],
        //         orderId: widget.product['orderid'],
        //       );
        //     }),
        // Divider(
        //   thickness: 1.5,
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: customText("Price Breakup",
        //       size: 14, fontWeight: FontWeight.bold),
        // ),
        // rowTwoChild(
        //   "Order Price",
        //   widget.product['cartTotal'].toString(),
        // ),
        // rowTwoChild(
        //     "Shipping Charges", widget.product['deliverycharge'].toString(),
        //     iconshow: true, icon: Icons.add),
        // rowTwoChild("Coupon / Discount", widget.product['discount'].toString(),
        //     iconshow: true, icon: Icons.remove),
        // Divider(
        //   thickness: 1.5,
        // ),
        // rowTwoChild("Order Total", widget.product['orderTotal'].toString(),
        //     weight: FontWeight.bold),
        // Divider(
        //   thickness: 1.5,
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        //   child: customText("Shipping Address",
        //       size: 12, fontWeight: FontWeight.bold),
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8),
        //   child: customText(widget.product['orderAddress'], size: 12),
        // ),
        // Text(deliveryDate),
        // InkWell(
        //   onTap: () async {
        //     final choice = await showDatePicker(
        //             context: context,
        //             firstDate: DateTime(2010),
        //             lastDate: DateTime(2030),
        //             initialDate: DateTime.now())
        //         .then((value) {
        //       setState(() {
        //         deliveryDate = DateFormat('yyyy-MM-dd').format(value!);
        //       });
        //     });

        //     print(choice);
        //     // s
        //   },
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Colors.grey[100],
        //       borderRadius: BorderRadius.circular(10.0),
        //     ),
        //     alignment: Alignment.center,
        //     width: double.maxFinite,
        //     padding: EdgeInsets.symmetric(vertical: 16),
        //     child: customText("Delivery Date $deliveryDate", size: 14),
        //   ),
        // ),

        // Text(product['orderAddress']),
        SizedBox(
          height: 6,
        ),
        Divider(
          thickness: 8,
          color: Colors.grey[200],
          height: 20,
        ),
      ],
    );
  }
}

class CartProduct extends StatefulWidget {
  final order;
  final String? orderStatus;
  final String? orderId;
  final bool adminView;
  const CartProduct(
      {Key? key,
      this.order,
      required this.orderStatus,
      required this.orderId,
      this.adminView = false})
      : super(key: key);

  @override
  _CartProductState createState() => _CartProductState();
}

DatabaseService databaseService = DatabaseService();

class _CartProductState extends State<CartProduct> {
  // ReviewModel reviewModel = ReviewModel();
  TextEditingController reviewController = TextEditingController();
  bool reviewSubmitted = false;
  double rating = 0.0;
  updateReview() async {
    await databaseService.addReview(
        GetStorage().read('mob'), widget.orderId, widget.order['pid'], rating);
    print(widget.order['pid']);
    await databaseService.addReviewToProduct(
      widget.order['pid'],
      widget.orderId,
      rating / 5,
      ReviewModel(
          review: reviewController.text,
          rating: rating,
          reviewBy: GetStorage().read('name'),
          reviewDate: Jiffy(DateTime.now()).format("MMM do, yyyy")),
    );
  }

  openAddUser(context, controller, reviewSubmitted) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height / 1.8,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.9),
                  borderRadius: BorderRadius.circular(24)),
              // height: MediaQuery.of(context).size.height / 1.6,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 92,
                      width: 92,
                      decoration: BoxDecoration(
                          color: yellow,
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: shadow,
                          border: Border.all(width: 8.0, color: Colors.white)),
                      child: Image.network(widget.order['productpic']),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 72.0, vertical: 16.0),
                      child: Text(
                        widget.order['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(),
                    Center(
                      child: RatingBar(
                        //                      borderColor: Color(0xffFF8993),
                        //                      fillColor: Color(0xffFF8993),
                        // ignoreGestures: true,
                        itemSize: 20,
                        allowHalfRating: true,
                        glowColor: Colors.black,
                        initialRating: 1,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        ratingWidget: RatingWidget(
                          empty: Icon(Icons.favorite_border,
                              color: Color(0xffFF8993), size: 20),
                          full: Icon(
                            Icons.favorite,
                            color: Color(0xffFF8993),
                            size: 20,
                          ),
                          half: Image.asset('assets/icons/half_heart.png'),
                        ),
                        onRatingUpdate: (value) {
                          setState(() {
                            rating = value;
                          });
                          print(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 12),
                      child: Text(
                        'Review ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white,
                        child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            enabled: true,
                            maxLines: 2,
                            maxLength: 120,
                            // keyboardType: inputtype,
                            controller: controller,
                            style: TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                                // prefixIcon: icon,
                                // filled: true,
                                // isDense: false,
                                border: InputBorder.none),
                            onChanged: (val) {}),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {
                          updateReview();
                          setState(() {
                            this.reviewSubmitted = true;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          height: 50,
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          // child: CustomText(
                          //   text: "Add User",
                          //   color: Colors.white,
                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Add Review',
                                style: TextStyle(
                                    letterSpacing: 1.3,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.order);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.11,
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white, width: 2),
                  // shape: BoxShape.circle,
                  color: Colors.yellow[800],
                  image: DecorationImage(
                      image: NetworkImage(widget.order['productpic']),
                      fit: BoxFit.fill)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  widget.order['name'],
                  style: TextStyle(
                      fontFamily: 'teko',
                      fontSize: 14,
                      color: Colors.grey,
                      letterSpacing: 1.4),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.rupeeSign,
                      color: Colors.grey[400],
                      size: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        widget.order['saleprice'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            letterSpacing: 1.4,
                            color: Colors.pink),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                      child: VerticalDivider(
                        color: Colors.black,
                      ),
                    ),
                    // Spacer(),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    RichText(
                      text: TextSpan(
                        text: 'Qty: ',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: '1',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              widget.order['rating'] == 0 &&
                      widget.orderStatus == 'Delivered' &&
                      !reviewSubmitted
                  ? InkWell(
                      onTap: () {
                        openAddUser(context, reviewController, reviewSubmitted);
                        // res.then(() {
                        //   setState(() {
                        //     reviewSubmitted = true;
                        //   });
                        // });
                        // showModalBottomSheet(
                        //   context: context,
                        //   builder: (context) {
                        //     return RatingReviewBottomSheet(
                        //       order: widget.order,
                        //     );
                        //   },
                        //   //elevation: 0,
                        //   //backgroundColor: Colors.transparent
                        // );
                      },
                      child: Text('Write a review'))
                  //  RatingBar(
                  //     itemSize: 24,
                  //     allowHalfRating: false,
                  //     initialRating: 1,
                  //     itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  //     onRatingUpdate: (value) {},
                  //     ratingWidget: RatingWidget(
                  //       empty: Icon(Icons.favorite_border,
                  //           color: Color(0xffFF8993), size: 20),
                  //       full: Icon(
                  //         Icons.favorite,
                  //         color: Color(0xffFF8993),
                  //         size: 20,
                  //       ),
                  //       half: SizedBox(),
                  //     ),
                  //   )
                  : textWithIcon(
                      Icons.star, 12.0, widget.order['rating'].toString(),
                      color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
