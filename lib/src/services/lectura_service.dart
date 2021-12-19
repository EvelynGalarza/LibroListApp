import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prylibro/src/models/fields_model.dart';

class LecturaApp {
  LecturaApp();

  final String _rootUrl = 'https://aporte-de-comenius.web.app/api/lecturas';

  Future<List<Lectura>> getLectura() async {
    List<Lectura> resultLectura = [];
    try {
      var url = Uri.parse(_rootUrl);
      final responseList = await http.get(url);
      List<dynamic> listLectura = json.decode(responseList.body);

      for (var item in listLectura) {
        final lectura = Lectura.fromJson(item);
        resultLectura.add(lectura);
      }
    } catch (ex) {
      //print(ex);
      return resultLectura;
    }

    return resultLectura;
  }
}
