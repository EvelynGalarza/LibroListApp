import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:prylibro/src/models/usuario_model.dart';
import 'package:prylibro/src/providers/usuario_provider.dart';
import 'package:prylibro/src/pages/login_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key, required this.currentUsuario}) : super(key: key);
  final CollectionReference currentUsuario;
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: StreamBuilder(
          stream:
              widget.currentUsuario.where("uid", isEqualTo: userId).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Cargando'));
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: snapshot.data!.docs.map((pasajeros) {
                var cls =
                    Usuario.fromJson(pasajeros.data() as Map<String, dynamic>);
                return Flexible(
                  child: ListView(children: [
                    Card(
                        child: ListTile(
                            trailing: IconButton(
                                onPressed: () async {
                                  mainProvider.token = "";
                                  await _auth.signOut();
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                                icon: const Icon(Icons.logout)),
                            leading: const Icon(Icons.person),
                            title: Text(cls.nombre),
                            subtitle: const Text("Nombre"))),
                    Card(
                        child: ListTile(
                            leading: const Icon(Icons.important_devices),
                            title: Text(cls.uid.toString()),
                            subtitle: const Text("Id"))),
                    Card(
                        child: ListTile(
                            leading: const Icon(Icons.email),
                            title: Text(cls.correo),
                            subtitle: const Text("Correo electrónico"))),
                    const SettingMode()
                  ]),
                );
              }).toList(),
            );
          }),
    );
  }
}

class SettingMode extends StatelessWidget {
  const SettingMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.light_mode),
        title: const Text("Modo claro"),
        subtitle: const Text("Habilitar / deshabilitar el modo claro"),
        trailing: Switch(
            value: mainProvider.mode,
            onChanged: (bool value) async {
              mainProvider.mode = value;
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool("mode", value);
            }),
      ),
    );
  }
}
