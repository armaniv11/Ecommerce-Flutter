import 'package:json_annotation/json_annotation.dart';
part 'reviewModel.g.dart';

@JsonSerializable()
class ReviewModel {
  String? reviewBy;
  String? review;
  double? rating;
  String? reviewDate;

  ReviewModel({this.reviewBy, this.review, this.rating, this.reviewDate});
  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
