import 'package:flutter/material.dart';
import 'package:prylibro/src/models/fields_model.dart';

class LecturaCard extends StatelessWidget {
  const LecturaCard({Key? key, required this.model}) : super(key: key);
  final Lectura model;
  @override
  Widget build(BuildContext context) {
    final url =
        model.fieldsProto?.libros!.mapValue!.fields!.imagen!.stringValue;
    return Card(
      elevation: 7.0,
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(url.toString())),
        title: Text(model
            .fieldsProto!.libros!.mapValue!.fields!.titulo!.stringValue
            .toString()),
        subtitle: Text(model
            .fieldsProto!.libros!.mapValue!.fields!.editorial!.stringValue
            .toString()),
        trailing: Text(model
            .fieldsProto!.libros!.mapValue!.fields!.autor!.stringValue
            .toString()),
      ),
    );
  }
}
