import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MapaPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  MapaPage({Key? key, required String Mapa}) : super(key: key);
  final LatLng librolist = const LatLng(-1.2650512, -78.628363);
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  String currentLocation = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Libros en presentación fisica'),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              height: 550,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 7,
                  ),
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: GoogleMap(
                markers: _libreria(),
                myLocationEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: widget.librolist, zoom: 18),
              ),
            ),
          ],
        ));
  }

  Set<Marker> _libreria() {
    var tmp = Set<Marker>();
    tmp.add(Marker(
      markerId: const MarkerId("Mr. Books"),
      position: widget.librolist,
      infoWindow: const InfoWindow(
        title: "Libreria",
      ),
    ));

    return tmp;
  }
}
