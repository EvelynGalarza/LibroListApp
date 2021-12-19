// To parse this JSON data, do
//

import 'dart:convert';

import 'genero_model.dart';

Libro libroFromJson(String str) => Libro.fromJson(json.decode(str));

String libroToJson(Libro data) => json.encode(data.toJson());

class Libro {
  Libro({
    this.titulo,
    this.autor,
    this.editorial,
    this.fechaPublicacion,
    this.idiomaOriginal,
    this.idiomaLectura,
    this.generos,
    this.descripcion,
    this.imagen,
  });

  String? titulo;
  String? autor;
  String? editorial;
  String? fechaPublicacion;
  String? idiomaOriginal;
  String? idiomaLectura;
  List<Genero>? generos;
  String? descripcion;
  String? imagen;

  factory Libro.fromJson(Map<String, dynamic> json) => Libro(
        titulo: json["titulo"],
        autor: json["autor"],
        editorial: json["editorial"],
        fechaPublicacion: json["fechaPublicacion"],
        idiomaOriginal: json["idiomaOriginal"],
        idiomaLectura: json["idiomaLectura"],
        generos:
            List<Genero>.from(json["generos"].map((x) => Genero.fromJson(x))),
        descripcion: json["descripcion"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "autor": autor,
        "editorial": editorial,
        "fechaPublicacion": fechaPublicacion,
        "idiomaOriginal": idiomaOriginal,
        "idiomaLectura": idiomaLectura,
        "generos": List<dynamic>.from(generos!.map((x) => x.toJson())),
        "descripcion": descripcion,
        "imagen": imagen,
      };
}
