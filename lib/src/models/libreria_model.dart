import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UbicacionLib libLocationFromJson(String str) =>
    UbicacionLib.fromJson(json.decode(str));

class UbicacionLib {
  UbicacionLib({
    this.name,
    this.location,
  });

  String? name;
  GeoPoint? location;

  factory UbicacionLib.fromJson(Map<String, dynamic> json) => UbicacionLib(
        name: json["nombre"],
        location: (json["localizacion"]),
      );
}

class Location {
  Location({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["_latitude"].toDouble(),
        longitude: json["_longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_latitude": latitude,
        "_longitude": longitude,
      };
}
