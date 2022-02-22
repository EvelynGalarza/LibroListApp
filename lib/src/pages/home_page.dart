import 'dart:async';
import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:provider/provider.dart';
import 'package:prylibro/src/pages/setting_page.dart';
import 'package:prylibro/src/providers/usuario_provider.dart';
import 'package:prylibro/src/utils/main_menu.dart';
import 'package:prylibro/src/providers/providers.dart';
import 'package:prylibro/src/widgets/lectura_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'map.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List fonts = [
  GoogleFonts.aBeeZee,
  GoogleFonts.pacifico,
  GoogleFonts.lobster,
  GoogleFonts.combo,
];

var fontName = <String>[
  'aBeeZee',
  'pacifico',
  'lobster',
  'combo',
];
int myindex = 0;
String _selectedFont = "aBeeZee";
CollectionReference usuario = FirebaseFirestore.instance.collection('usuario');

class _HomePageState extends State<HomePage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final PageStorageBucket _bucket = PageStorageBucket();
  final temaController = Get.put(TemaProvider());
  int _selectedIndex = 1;

  //get temaController => null;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  final List<Widget> _widgetOptions = <Widget>[
    const Text(
      'Index 0: Mis Libros',
      style: optionStyle,
    ),
    const LecturaWidget(),
    const Text(
      'Index 2: Seguimiento',
      style: optionStyle,
    ),
    SettingPage(currentUsuario: usuario),
  ];
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  final List<String> _options = ["Registro", "Biblioteca", "Ajustes"];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(_options[1]),
            leading: GestureDetector(
                onTap: () {/* Write listener code here */},
                child: Switch(
                    value: mainProvider.mode,
                    onChanged: (bool value) async {
                      mainProvider.mode = value;
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool("mode", value);
                    })),
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.search,
                      size: 26.0,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapaPage(
                                    Mapa: "",
                                  )));
                    },
                    child: const Icon(Icons.map_rounded),
                  )),
            ]),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Mis Libros',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: 'Biblioteca',
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'Seguimiento',
                backgroundColor: Colors.purple,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Configuracion',
                backgroundColor: Colors.pink,
              ),
            ],
            currentIndex: _selectedIndex),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }
}
