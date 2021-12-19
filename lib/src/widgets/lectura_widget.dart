import 'package:flutter/material.dart';
import 'package:prylibro/src/models/fields_model.dart';
import 'package:prylibro/src/services/lectura_service.dart';
import 'package:prylibro/src/widgets/lectura_card.dart';

class LecturaWidget extends StatefulWidget {
  const LecturaWidget({Key? key}) : super(key: key);

  @override
  _LecturaWidgetState createState() => _LecturaWidgetState();
}

class _LecturaWidgetState extends State<LecturaWidget> {
  final LecturaApp _lecturaapp = LecturaApp();
  List<Lectura>? _listlectura;

  @override
  void initState() {
    super.initState();
    _downloadlectura();
  }

  @override
  Widget build(BuildContext context) {
    return _listlectura == null
        ? const Center(
            child: SizedBox(
                height: 50.0, width: 50.0, child: CircularProgressIndicator()))
        : _listlectura!.isEmpty
            ? const Center(child: SizedBox(child: Text("No Hay Lecturas")))
            : Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 14.0),
                child: ListView(
                    children: _listlectura!
                        .map((e) => LecturaCard(model: e))
                        .toList()));
  }

  _downloadlectura() async {
    _listlectura = await _lecturaapp.getLectura();
    setState(() {});
  }
}
