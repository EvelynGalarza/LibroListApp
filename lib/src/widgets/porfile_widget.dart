import 'package:flutter/material.dart';

class PorfilWidget extends StatelessWidget {
  const PorfilWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.settings_accessibility_outlined, size: 50.0),
        Text("Ajustes de Perfil", style: Theme.of(context).textTheme.headline4)
      ],
    ));
  }
}
