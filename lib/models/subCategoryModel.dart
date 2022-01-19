import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SubCategoryModel {
  String? category;
  String? subCategory;

  SubCategoryModel({this.category, this.subCategory});
}
