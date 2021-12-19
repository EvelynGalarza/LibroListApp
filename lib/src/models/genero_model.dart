// To parse this JSON data, do
//

import 'dart:convert';

Genero libroFromJson(String str) => Genero.fromJson(json.decode(str));

String libroToJson(Genero data) => json.encode(data.toJson());

class Genero {
  Genero({
    this.idGen,
    this.tituloGen,
  });

  int? idGen;
  String? tituloGen;

  factory Genero.fromJson(Map<String, dynamic> json) => Genero(
        idGen: json["idGen"],
        tituloGen: json["tituloGen"],
      );

  Map<String, dynamic> toJson() => {
        "idGen": idGen,
        "tituloGen": tituloGen,
      };
}
