import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prylibro/src/models/libreria_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer' as dev;

class Mapa extends StatefulWidget {
  // ignore: non_constant_identifier_names
  const Mapa({Key? key, required String Localizacion}) : super(key: key);
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  List<UbicacionLib> ubicacionlib = [];
  final List<Marker> _libreria = <Marker>[];
  late LatLng inicio = const LatLng(-1.2650512, -78.628363);
  @override
  void initState() {
    _getGPSData().then((value) {
      setState(() {
        _marcador(ubicacionlib);
      });
    });

    super.initState();
  }

  _marcador(List<UbicacionLib> librerias) {
    for (var doc in librerias) {
      dev.log(doc.location!.latitude.toString(), name: "Ubicacion");
      _libreria.add(Marker(
        markerId: MarkerId(doc.name.toString()),
        position: LatLng(doc.location!.latitude, doc.location!.longitude),
        infoWindow: InfoWindow(
          title: doc.name.toString(),
        ),
      ));
      if (mounted) {
        setState(() {});
      }
      dev.log(_libreria.toString(), name: "Ubicacion");
    }
  }

  //
  _getGPSData() async {
    dev.log("Getting Firebase data");
    var collection = FirebaseFirestore.instance.collection('librerias');
    var querySnapshot = await collection.get();
    dev.log(querySnapshot.docs.toString());
    dev.log(querySnapshot.docs[0].data().toString());
    for (var dato in querySnapshot.docs) {
      ubicacionlib.add(UbicacionLib.fromJson(dato.data()));
      dev.log(dato.data().toString());
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Librerias",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        body: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              height: 650,
              child: GoogleMap(
                markers: Set<Marker>.of(_libreria),
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(target: inicio, zoom: 18),
              ),
            ),
          ],
        ));
  }
}
