

import 'package:first/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel{
  final String id;
  final String userName;
  @JsonKey(
    fromJson: DataUtils.pathToUrl
  )
  final String imageUrl;

  UserModel({
    required this.id, required this.userName, required this.imageUrl
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}