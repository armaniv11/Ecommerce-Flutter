// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profilemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      profilepic: json['profilepic'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      mob: json['mob'] as String?,
      address: json['address'] as String?,
      createdat: json['createdat'] as String?,
      city: json['city'] as String? ?? '',
      pincode: json['pincode'] as String? ?? '',
      updatedat: json['updatedat'] as String? ?? '',
      verified: json['verified'] as bool? ?? false,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'profilepic': instance.profilepic,
      'name': instance.name,
      'mob': instance.mob,
      'email': instance.email,
      'address': instance.address,
      'createdat': instance.createdat,
      'city': instance.city,
      'pincode': instance.pincode,
      'updatedat': instance.updatedat,
      'verified': instance.verified,
    };
