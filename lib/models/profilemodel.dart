import 'package:json_annotation/json_annotation.dart';
part 'profilemodel.g.dart';

@JsonSerializable()
class ProfileModel {
  String? profilepic;
  String? name;
  String? mob;
  String? email;
  String? address;
  String? createdat;
  String? city;
  String? pincode;
  String? updatedat;
  bool? verified;

  ProfileModel({
    this.profilepic,
    this.name,
    this.email,
    this.mob,
    this.address,
    this.createdat,
    this.city = '',
    this.pincode = '',
    this.updatedat = '',
    this.verified = false,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
