import 'package:dns/models/productmodel.dart';

class OrderModel {
  List<ProductModel> orders = [];
  String? orderId;
  String? createdat;
  String? updatedat;
  double? cartTotal;
  double? orderTotal;
  double? taxes;
  double? discount;
  String? coupon;
  String? orderStatus;
  String? orderAddress;
  String? orderMob;
  double? deliverycharge;
}
