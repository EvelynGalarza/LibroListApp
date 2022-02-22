import 'dart:convert';

Usuario materialFromJson(String str) => Usuario.fromJson(json.decode(str));

String materialToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario(
      {this.idUsuario,
      required this.correo,
      required this.nombre,
      required this.contrasenia,
      required this.uid});

  int? idUsuario;
  String correo;
  String nombre;
  String contrasenia;
  String uid;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      idUsuario: json["idUsuario"],
      correo: json["correo"],
      nombre: json["nombre"],
      contrasenia: json["contrasenia"],
      uid: json["uid"]);

  factory Usuario.created() =>
      Usuario(correo: "", nombre: "", contrasenia: "", uid: "");

  Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "correo": correo,
        "nombre": nombre,
        "contrasenia": contrasenia,
        "uid": uid
      };
}
