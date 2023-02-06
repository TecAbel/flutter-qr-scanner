// To parse this JSON data, do
//
// final qrModel = qrModelFromJson(jsonString);

import 'dart:convert';

QrModel qrModelFromJson(String str) => QrModel.fromJson(json.decode(str));

String qrModelToJson(QrModel data) => json.encode(data.toJson());

class QrModel {
  QrModel({
    this.id,
    this.type,
    required this.value,
  }) {
    if (value.contains('http')) {
      type = 'url';
    } else {
      type = 'geo';
    }
  }

  int? id;
  String? type;
  String value;

  factory QrModel.fromJson(Map<String, dynamic> json) => QrModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
      };
}
