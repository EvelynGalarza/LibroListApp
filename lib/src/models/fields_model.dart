// To parse this JSON data, do
//
//     final lectura = lecturaFromJson(jsonString);

import 'dart:convert';

List<Lectura> lecturaFromJson(String str) =>
    List<Lectura>.from(json.decode(str).map((x) => Lectura.fromJson(x)));

String lecturaToJson(List<Lectura> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Lectura {
  Lectura({
    this.fieldsProto,
  });

  FieldsProto? fieldsProto;

  factory Lectura.fromJson(Map<String, dynamic> json) => Lectura(
        fieldsProto: FieldsProto.fromJson(json["_fieldsProto"]),
      );

  Map<String, dynamic> toJson() => {
        "_fieldsProto": fieldsProto!.toJson(),
      };
}

class FieldsProto {
  FieldsProto({
    this.estado,
    this.libros,
    this.avance,
    this.idLibro,
  });

  Avance? estado;
  Libros? libros;
  Avance? avance;
  Avance? idLibro;

  factory FieldsProto.fromJson(Map<String, dynamic> json) => FieldsProto(
        estado: Avance.fromJson(json["estado"]),
        libros: Libros.fromJson(json["libros"]),
        avance: Avance.fromJson(json["avance"]),
        idLibro: Avance.fromJson(json["idLibro"]),
      );

  Map<String, dynamic> toJson() => {
        "estado": estado!.toJson(),
        "libros": libros!.toJson(),
        "avance": avance!.toJson(),
        "idLibro": idLibro!.toJson(),
      };
}

class Avance {
  Avance({
    this.integerValue,
    this.valueType,
  });

  String? integerValue;
  String? valueType;

  factory Avance.fromJson(Map<String, dynamic> json) => Avance(
        integerValue: json["integerValue"],
        valueType: json["valueType"],
      );

  Map<String, dynamic> toJson() => {
        "integerValue": integerValue,
        "valueType": valueType,
      };
}

class Libros {
  Libros({
    this.mapValue,
    this.valueType,
  });

  LibrosMapValue? mapValue;
  String? valueType;

  factory Libros.fromJson(Map<String, dynamic> json) => Libros(
        mapValue: LibrosMapValue.fromJson(json["mapValue"]),
        valueType: json["valueType"],
      );

  Map<String, dynamic> toJson() => {
        "mapValue": mapValue!.toJson(),
        "valueType": valueType,
      };
}

class LibrosMapValue {
  LibrosMapValue({
    this.fields,
  });

  PurpleFields? fields;

  factory LibrosMapValue.fromJson(Map<String, dynamic> json) => LibrosMapValue(
        fields: PurpleFields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "fields": fields!.toJson(),
      };
}

class PurpleFields {
  PurpleFields({
    this.autor,
    this.imagen,
    this.editorial,
    this.genero,
    this.idiomaLectura,
    this.descripcion,
    this.titulo,
    this.idiomaOriginal,
    this.fechaPublicacion,
  });

  Autor? autor;
  Autor? imagen;
  Autor? editorial;
  Genero? genero;
  Autor? idiomaLectura;
  Autor? descripcion;
  Autor? titulo;
  Autor? idiomaOriginal;
  Autor? fechaPublicacion;

  factory PurpleFields.fromJson(Map<String, dynamic> json) => PurpleFields(
        autor: Autor.fromJson(json["autor"]),
        imagen: Autor.fromJson(json["imagen"]),
        editorial: Autor.fromJson(json["editorial"]),
        genero: Genero.fromJson(json["genero"]),
        idiomaLectura: Autor.fromJson(json["idiomaLectura"]),
        descripcion: Autor.fromJson(json["descripcion"]),
        titulo: Autor.fromJson(json["titulo"]),
        idiomaOriginal: Autor.fromJson(json["idiomaOriginal"]),
        fechaPublicacion: Autor.fromJson(json["fechaPublicacion"]),
      );

  Map<String, dynamic> toJson() => {
        "autor": autor!.toJson(),
        "imagen": imagen!.toJson(),
        "editorial": editorial!.toJson(),
        "genero": genero!.toJson(),
        "idiomaLectura": idiomaLectura!.toJson(),
        "descripcion": descripcion!.toJson(),
        "titulo": titulo!.toJson(),
        "idiomaOriginal": idiomaOriginal!.toJson(),
        "fechaPublicacion": fechaPublicacion!.toJson(),
      };
}

class Autor {
  Autor({
    this.stringValue,
    this.valueType,
  });

  String? stringValue;
  String? valueType;

  factory Autor.fromJson(Map<String, dynamic> json) => Autor(
        stringValue: json["stringValue"],
        valueType: json["valueType"],
      );

  Map<String, dynamic> toJson() => {
        "stringValue": stringValue,
        "valueType": valueType,
      };
}

class Genero {
  Genero({
    this.mapValue,
    this.valueType,
  });

  GeneroMapValue? mapValue;
  String? valueType;

  factory Genero.fromJson(Map<String, dynamic> json) => Genero(
        mapValue: GeneroMapValue.fromJson(json["mapValue"]),
        valueType: json["valueType"],
      );

  Map<String, dynamic> toJson() => {
        "mapValue": mapValue!.toJson(),
        "valueType": valueType,
      };
}

class GeneroMapValue {
  GeneroMapValue({
    this.fields,
  });

  FluffyFields? fields;

  factory GeneroMapValue.fromJson(Map<String, dynamic> json) => GeneroMapValue(
        fields: FluffyFields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "fields": fields!.toJson(),
      };
}

class FluffyFields {
  FluffyFields({
    this.tituloGen,
    this.idGen,
  });

  Autor? tituloGen;
  Avance? idGen;

  factory FluffyFields.fromJson(Map<String, dynamic> json) => FluffyFields(
        tituloGen: Autor.fromJson(json["tituloGen"]),
        idGen: Avance.fromJson(json["idGen"]),
      );

  Map<String, dynamic> toJson() => {
        "tituloGen": tituloGen!.toJson(),
        "idGen": idGen!.toJson(),
      };
}
