import 'package:flutter/material.dart';
import 'package:prylibro/src/widgets/lectura_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: const Icon(Icons.more_vert),
                  )),
            ]),
        body: const LecturaWidget());
  }
}
