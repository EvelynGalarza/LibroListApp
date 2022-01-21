import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prylibro/src/widgets/lectura_widget.dart';
import 'package:prylibro/src/widgets/register_widget.dart';
import 'package:prylibro/src/widgets/porfile_widget.dart';

class MenuItem {
  String label;
  IconData icon;

  MenuItem(this.label, this.icon);
}

List<MenuItem> menuOption = [
  MenuItem("Registro", Icons.person),
  MenuItem("Biblioteca", Icons.book),
  MenuItem("Ajustes", Icons.settings),
];

List<Widget> contentWidgets = [
  const RegisterWidget(),
  const LecturaWidget(),
  const PorfilWidget()
];
