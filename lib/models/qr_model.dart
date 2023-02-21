// To parse this JSON data, do
//
// final qrModel = qrModelFromJson(jsonString);

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

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

  LatLng getLatLng() {
    final value = this.value.substring(4).split(',');

    final lat = double.parse(value[0]);
    final lon = double.parse(value[1]);

    return LatLng(lat, lon);
  }

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
