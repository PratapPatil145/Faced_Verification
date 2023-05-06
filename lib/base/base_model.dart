import 'package:json_annotation/json_annotation.dart';

class BaseModel {
  @JsonKey(name: "statusMessage")
  String? statusMessage;

  @JsonKey(name: "statusCode")
  int? statusCode;

  BaseModel({this.statusMessage, this.statusCode});
}