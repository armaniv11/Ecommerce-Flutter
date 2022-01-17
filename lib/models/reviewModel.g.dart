// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      reviewBy: json['reviewBy'] as String?,
      review: json['review'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewDate: json['reviewDate'] as String?,
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'reviewBy': instance.reviewBy,
      'review': instance.review,
      'rating': instance.rating,
      'reviewDate': instance.reviewDate,
    };
