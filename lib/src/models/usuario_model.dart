import 'dart:convert';

Usuario materialFromJson(String str) => Usuario.fromJson(json.decode(str));

String materialToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario(
      {this.idUsuario,
      required this.correo,
      required this.nombre,
      required this.contrasenia});

  int? idUsuario;
  String correo;
  String nombre;
  String contrasenia;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      idUsuario: json["idUsuario"],
      correo: json["correo"],
      nombre: json["nombre"],
      contrasenia: json["contrasenia"]);

  factory Usuario.created() => Usuario(correo: "", nombre: "", contrasenia: "");

  Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "correo": correo,
        "nombre": nombre,
        "contrasenia": contrasenia
      };
}
