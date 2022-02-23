import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prylibro/blocs/singup_bloc.dart';
import 'package:prylibro/src/pages/login_page.dart';
import 'package:prylibro/src/providers/img_provider.dart';

// ignore: unused_element
late bool? _success;

// ignore: unused_element
late String _userEmail = ''; //email vacio
late String us = ""; //uid identificar unico del usurio

final FirebaseAuth _auth = FirebaseAuth.instance;

final contrasenia = TextEditingController();
final correo = TextEditingController();

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  File? _imagen;
  String? urlImagen;
  bool _obscureText = true;

  final SignUpBloc _signUpBloc = SignUpBloc();
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
    double size = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Stack(children: [
        Container(
          color: Theme.of(context).primaryColorDark,
          height: size * 0.4,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 35.0, right: 35.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Registro de usuario",
                    style: Theme.of(context).textTheme.headline4!.apply(
                        color: Theme.of(context).scaffoldBackgroundColor)),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).hintColor, width: 2.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<String>(
                          stream: _signUpBloc.usernameStream,
                          builder: (context, snapshot) {
                            return TextField(
                                controller: nombre,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: _signUpBloc.changeUsername,
                                decoration: InputDecoration(
                                    errorText: snapshot.error?.toString(),
                                    icon: const Icon(Icons.person),
                                    labelText: "Nombre",
                                    hintText: "Nombre y apellido"));
                          }),
                      StreamBuilder<String>(
                          stream: _signUpBloc.emailStream,
                          builder: (context, snapshot) {
                            return TextField(
                                controller: correo,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: _signUpBloc.changeEmail,
                                decoration: InputDecoration(
                                    errorText: snapshot.error?.toString(),
                                    icon: const Icon(Icons.email),
                                    labelText: "Correo electrónico",
                                    hintText: "usuario@correo.com"));
                          }),
                      StreamBuilder<String>(
                          stream: _signUpBloc.passwordStream,
                          builder: (context, snapshot) {
                            //validaciones bloc
                            return TextField(
                                controller: contrasenia,
                                onChanged: _signUpBloc.changePassword,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                    errorText: snapshot.error?.toString(),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          _obscureText = !_obscureText;
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        )),
                                    icon: const Icon(Icons.lock),
                                    labelText: "Contraseña"));
                          }),
                      const ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 70),
                        title: Text("Escoja su Foto de Perfil"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                  color: Colors.black,
                                  child: const Icon(
                                    Icons.camera,
                                    color: Colors.white,
                                  ),
                                  onPressed: () =>
                                      _selectImage(ImageSource.camera)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                  color: Colors.black,
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  onPressed: () =>
                                      _selectImage(ImageSource.gallery)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: StreamBuilder<bool>(
                            stream: _signUpBloc.formSignUpStream,
                            builder: (context, snapshot) {
                              return ElevatedButton.icon(
                                  onPressed: snapshot.hasData
                                      ? () async {
                                          try {
                                            await _registerintheDDB();
                                            if (_success = true) {
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginPage()));
                                              setState(() {});
                                            }
                                          } catch (e) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Error email ya registrado"),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          TextButton(
                                                              style: ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .black87)),
                                                              child: const Text(
                                                                'Regresar',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const RegisterWidget()),
                                                                );
                                                              }),
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                });
                                          }
                                        }
                                      : null,
                                  icon: const Icon(Icons.app_registration),
                                  label: const Text("Registrarte"));
                            }),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ])),
    ));
  }

//primer regristro crear uid
  Future<void> _registerintheDDB() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: correo.text,
      password: contrasenia.text,
    ))
        .user;
    us = user!.uid;
    if (user != null) {
      await _servidor();

      setState(() {
        _success = true;
        _userEmail = user.email ?? '';
      });
    } else {
      _success = false;
    }
  }

//segundo registro guarda uid
  Future<void> _servidor() async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('usuario');
      await reference.add({
        "uid": us,
        "nombre": nombre.text,
        "correo": correo.text,
        "contrasenia": contrasenia.text,
        "imagen": urlImagen,
      });
    });
  }
}
