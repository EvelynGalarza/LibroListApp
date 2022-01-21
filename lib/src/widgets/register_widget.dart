import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prylibro/src/pages/home_page.dart';
import 'package:prylibro/src/providers/img_provider.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  File? _imagen;
  String? urlImagen;
  final contrasenia = TextEditingController();
  final correo = TextEditingController();
  final nombre = TextEditingController();
  final FotosService _fotosService = FotosService();

  Future _selectImage(ImageSource source) async {
    final imageCamera = await ImagePicker().pickImage(source: source);
    if (imageCamera == null) return;
    final imageTemporary = File(imageCamera.path);
    _imagen = imageTemporary;
    if (_imagen != null) {
      urlImagen = await _fotosService.uploadImage(_imagen!);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.person, size: 50.0),
        Text("Registro", style: Theme.of(context).textTheme.headline4),
        TextFormField(
            keyboardType: TextInputType.text,
            controller: correo,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Correo",
                prefixIcon: Icon(Icons.email_outlined)),
            maxLength: 100),
        TextFormField(
            keyboardType: TextInputType.text,
            controller: nombre,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Nombre",
              prefixIcon: Icon(Icons.person),
            ),
            maxLength: 100),
        TextFormField(
            keyboardType: TextInputType.text,
            controller: contrasenia,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Contraseña",
                prefixIcon: Icon(Icons.https)),
            maxLength: 50),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    child: const Icon(
                      Icons.photo_camera_outlined,
                      color: Colors.cyan,
                    ),
                    onPressed: () => _selectImage(ImageSource.camera)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    child: const Icon(
                      Icons.photo_outlined,
                      color: Colors.cyan,
                    ),
                    onPressed: () => _selectImage(ImageSource.gallery)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      child: const Text("Aceptar"),
                      onPressed: () async {
                        await _servidor();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  "Usuario Registrado",
                                  textAlign: TextAlign.center,
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const [
                                      Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          child: const Icon(
                                            Icons.save_outlined,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage()),
                                            );
                                          }),
                                    ],
                                  ),
                                ],
                              );
                            });
                      }),
                  MaterialButton(
                      child: const Text("Cancelar"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      }),
                ],
              )
            ],
          ),
        ),
      ],
    ));
  }

  Future<void> _servidor() async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('usuario');
      await reference.add({
        "nombre": nombre.text,
        "correo": correo.text,
        "contrasenia": contrasenia.text,
        "imagen": urlImagen,
      });
    });
  }
}
