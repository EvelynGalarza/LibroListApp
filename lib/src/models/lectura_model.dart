// To parse this JSON data, do
//

import 'dart:convert';

import 'libro_model.dart';

Lectura lecturaFromJson(String str) => Lectura.fromJson(json.decode(str));

String lecturaToJson(Lectura data) => json.encode(data.toJson());

class Lectura {
  Lectura({
    this.idLibro,
    this.estado,
    this.avance,
    this.libros,
  });

  int? idLibro;
  int? estado;
  int? avance;
  List<Libro>? libros;

  factory Lectura.fromJson(Map<String, dynamic> json) => Lectura(
        idLibro: json["idLibro"],
        estado: json["estado"],
        avance: json["avance"],
        libros: List<Libro>.from(json["Libros"].map((x) => Libro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "idLibro": idLibro,
        "estado": estado,
        "avance": avance,
        "Libros": List<dynamic>.from(libros!.map((x) => x.toJson())),
      };
}
