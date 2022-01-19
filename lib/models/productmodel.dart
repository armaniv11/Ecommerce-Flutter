import 'package:dns/models/reviewModel.dart';
import 'package:dns/models/userIdModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'productmodel.g.dart';

@JsonSerializable()
class ProductModel {
  String? productpic;
  String? name;
  String? desc;
  double? price;
  double? saleprice;
  String? careInstructions;
  String? category;
  bool? isFeatured;
  bool? onRent;
  bool? cod;
  bool? isReplacable;
  String? createdat;
  double deliveryCharge;
  String? pid;
  double rating;
  int? sellCount;
  int? quantity;
  Map<String, dynamic>? reviews;
  String? selectedAudience;
  int? maxSaleQty;
  String? uom;
  String? taxPercent;
  double stock;
  double rentAmount;
  double rentDeposit;

  ProductModel(
      {this.productpic,
      this.name,
      this.desc,
      this.price,
      this.saleprice,
      this.careInstructions = "",
      this.category,
      this.isFeatured = false,
      this.onRent = false,
      this.cod = true,
      this.isReplacable = false,
      this.createdat,
      this.deliveryCharge = 0.0,
      this.pid,
      this.rating = 0,
      this.sellCount,
      this.quantity = 1,
      this.reviews,
      this.selectedAudience,
      this.maxSaleQty = 2,
      this.uom = 'pcs',
      this.taxPercent = "0%",
      this.stock = 10,
      this.rentAmount = 0,
      this.rentDeposit = 0});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
