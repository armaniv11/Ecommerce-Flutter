import 'package:dns/admin/all_orders.dart';
import 'package:dns/custom_classes/custom_classes.dart';
import 'package:dns/custom_widgets/custom_rows.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/functions/database.dart';
import 'package:dns/models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  List? products = [];
  final orderDetails;
  OrderDetails({required this.products, this.orderDetails});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String deliveryDate = '';
  TextEditingController remarkController = TextEditingController();
  DatabaseService databaseService = DatabaseService();

  List<String> statusMenu = [
    'Ordered',
    'Shipped',
    'Delivered',
    'Cancelled',
    'refunded'
  ];
  String _selectedStatus = 'Ordered';
  void selectStatus(String selected) {
    setState(() {
      _selectedStatus = selected;
      order['orderStatus'] = _selectedStatus;
    });
  }

  Map<String, String> order = {};

  updateStatus() async {
    setState(() {
      isLoading = true;
    });
    order['remark'] = remarkController.text;
    if (order['orderStatus'] == 'Delivered') {
      await databaseService.updateSellCount(widget.orderDetails['orderid']);
    }
    await databaseService
        .updateOrder(widget.orderDetails['orderid'], order)
        .then((value) {
      customToast("Order has been updated successfully");
      Navigator.pop(context, order['orderStatus']);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    deliveryDate = widget.orderDetails['deliveryDate'] ?? "";
    remarkController.text = widget.orderDetails['remark'] ?? "";
    _selectedStatus = widget.orderDetails['orderStatus'] ?? "";

    // TODO: implement initState
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print(widget.orderDetails);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        title: Text("Order Id (${widget.orderDetails['orderid']})"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.products!.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return CartProduct(
                          order: widget.products![index],
                          orderStatus: widget.orderDetails['orderStatus'],
                          orderId: widget.orderDetails['orderid'],
                        );
                      }),
                  Divider(
                    thickness: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customText("Price Breakup",
                        size: 14, fontWeight: FontWeight.bold),
                  ),
                  rowTwoChild(
                    "Order Price",
                    widget.orderDetails['cartTotal'].toString(),
                  ),
                  rowTwoChild("Shipping Charges",
                      widget.orderDetails['deliverycharge'].toString(),
                      iconshow: true, icon: Icons.add),
                  rowTwoChild("Coupon / Discount",
                      widget.orderDetails['discount'].toString(),
                      iconshow: true, icon: Icons.remove),
                  Divider(
                    thickness: 1.5,
                  ),
                  rowTwoChild("Order Total",
                      widget.orderDetails['orderTotal'].toString(),
                      weight: FontWeight.bold),
                  Divider(
                    thickness: 1.5,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: customText("Shipping Address",
                        size: 12, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: customText(widget.orderDetails['orderAddress'],
                        size: 12),
                  ),
                  Divider(
                    thickness: 10,
                    height: 30,
                  ),
                  // Text(deliveryDate),
                  InkWell(
                    onTap: () async {
                      final dynamic choice = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2030),
                              initialDate: DateTime.now())
                          .then((value) {
                        setState(() {
                          deliveryDate =
                              DateFormat('yyyy-MM-dd').format(value!);
                          order['deliveryDate'] = deliveryDate;
                        });
                      });

                      print(choice);
                      // s
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: customText("Delivery Date $deliveryDate",
                            size: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  CustomDropDown(
                    heading: "Order Status",
                    items: statusMenu,
                    selected: _selectedStatus,
                    callBack: selectStatus,
                    color: Colors.black87,
                  ),
                  customTextFormField(
                      remarkController, "Order Remark", Icon(Icons.info),
                      headingColor: Colors.black, maxlength: 60, maxlines: 3),

                  InkWell(
                      onTap: () {
                        updateStatus();
                      },
                      child: customButton("Update Order"))
                ],
              ),
            ),
    );
  }
}
