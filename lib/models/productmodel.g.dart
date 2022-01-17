// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      productpic: json['productpic'] as String?,
      name: json['name'] as String?,
      desc: json['desc'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      saleprice: (json['saleprice'] as num?)?.toDouble(),
      careInstructions: json['careInstructions'] as String? ?? "",
      category: json['category'] as String?,
      isFeatured: json['isFeatured'] as bool? ?? false,
      onRent: json['onRent'] as bool? ?? false,
      cod: json['cod'] as bool? ?? true,
      isReplacable: json['isReplacable'] as bool? ?? false,
      createdat: json['createdat'] as String?,
      deliveryCharge: (json['deliveryCharge'] as num?)?.toDouble() ?? 0.0,
      pid: json['pid'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      sellCount: json['sellCount'] as int?,
      quantity: json['quantity'] as int? ?? 1,
      reviews: json['reviews'] as Map<String, dynamic>?,
      selectedAudience: json['selectedAudience'] as String?,
      maxSaleQty: json['maxSaleQty'] as int? ?? 2,
      uom: json['uom'] as String? ?? 'pcs.',
      taxPercent: json['taxPercent'] as String? ?? "0%",
      stock: (json['stock'] as num?)?.toDouble() ?? 10,
      rentAmount: (json['rentAmount'] as num?)?.toDouble() ?? 0,
      rentDeposit: (json['rentDeposit'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productpic': instance.productpic,
      'name': instance.name,
      'desc': instance.desc,
      'price': instance.price,
      'saleprice': instance.saleprice,
      'careInstructions': instance.careInstructions,
      'category': instance.category,
      'isFeatured': instance.isFeatured,
      'onRent': instance.onRent,
      'cod': instance.cod,
      'isReplacable': instance.isReplacable,
      'createdat': instance.createdat,
      'deliveryCharge': instance.deliveryCharge,
      'pid': instance.pid,
      'rating': instance.rating,
      'sellCount': instance.sellCount,
      'quantity': instance.quantity,
      'reviews': instance.reviews,
      'selectedAudience': instance.selectedAudience,
      'maxSaleQty': instance.maxSaleQty,
      'uom': instance.uom,
      'taxPercent': instance.taxPercent,
      'stock': instance.stock,
      'rentAmount': instance.rentAmount,
      'rentDeposit': instance.rentDeposit,
    };
