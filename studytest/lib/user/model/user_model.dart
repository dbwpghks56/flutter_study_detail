import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String password;

  UserModel({
    required this.id,
    required this.password
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

}