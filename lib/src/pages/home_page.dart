import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prylibro/src/providers/providers.dart';
import 'package:prylibro/src/widgets/lectura_widget.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
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

class _HomePageState extends State<HomePage> {
  final temaController = Get.put(TemaProvider());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const LecturaWidget(),
        appBar: AppBar(
            title: const Text("Biblioteca"),
            leading: GestureDetector(
              onTap: () {/* Write listener code here */},
              child: const Icon(
                Icons.menu, // add custom icons also
              ),
            ),
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
                    onTap: () {},
                    child: const Icon(Icons.light),
                  )),
            ]),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.view_list,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.wb_sunny),
              label: "claro",
              onTap: () => temaController.temaClaro(),
            ),
            SpeedDialChild(
              child: const Icon(Icons.mode_night),
              label: "oscuro",
              onTap: () => temaController.temaOscuro(),
            ),
            SpeedDialChild(
              child: const Icon(Icons.color_lens),
              label: "Personalizar",
              onTap: () => temaController.temaPersonalizado(),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
