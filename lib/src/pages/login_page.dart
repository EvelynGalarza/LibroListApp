import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:prylibro/src/pages/home_page.dart';
import 'package:prylibro/src/providers/usuario_provider.dart';

late bool _controllerbool = false;
final FirebaseAuth _authentificador = FirebaseAuth.instance;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
bool _obscureText = true;

User? user;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    _authentificador.userChanges().listen(
          (event) => setState(() => user = event),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Container(
        color: Theme.of(context).primaryColorDark,
      ),
      SingleChildScrollView(
          child: Center(
              child: SizedBox(
                  child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(child: Container(height: 12)),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text("Iniciar sesión",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor)),
          ),
          Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 14.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      width: 2.0, color: Theme.of(context).primaryColorDark)),
              child: Column(
                children: [
                  StreamBuilder(
                      builder: (BuildContext context, AsyncSnapshot snapshot) =>
                          TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  errorText: snapshot.error?.toString(),
                                  icon: const Icon(Icons.email),
                                  hintText: 'usuario@prylibro.com',
                                  labelText: 'Correo electrónico'))),
                  StreamBuilder(
                      builder: (BuildContext context, AsyncSnapshot snapshot) =>
                          TextField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      _obscureText = !_obscureText;
                                      setState(() {});
                                    },
                                    icon: _obscureText
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)),
                                errorText: snapshot.error?.toString(),
                                icon: const Icon(Icons.lock_outline),
                                labelText: 'Contraseña',
                              ))),
                  StreamBuilder(
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ElevatedButton.icon(
                          onPressed: () async {
                            await _userlogin();
                            if (_controllerbool) {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                              setState(() {});
                            }
                          },
                          icon: const Icon(Icons.login_sharp),
                          label: const Text("Ingresar")),
                    );
                  })
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("¿No tiene una cuenta?"),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/singUp");
                  },
                  child: const Text("Registrarse")),
            ],
          )
        ],
      )))),
    ])));
  }

  Future<void> _userlogin() async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    try {
      final User user = (await _authentificador.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user!;

      if (user.uid.isNotEmpty) {
        setState(() {
          mainProvider.token = user.uid; //buscar usuario ya creado
          _controllerbool = true;
        });
      } else {
        _controllerbool = false;
      }
    } catch (e) {
      //
    }
  }
}
