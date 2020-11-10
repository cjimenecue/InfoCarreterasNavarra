import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:info_carreteras_navarra/models/incidenciacarretera_model.dart';
import 'package:info_carreteras_navarra/screens/listincidencias_swiper_screen.dart';
import 'package:info_carreteras_navarra/screens/mapa_info_screen.dart';
import 'package:utm/utm.dart';
import 'package:latlong/latlong.dart';
import 'package:info_carreteras_navarra/providers/incidencias_provider.dart';

class MapaCompletoScreen extends StatefulWidget {
  MapaCompletoScreen({Key key}) : super(key: key);

  @override
  _MapaCompletoScreenState createState() => _MapaCompletoScreenState();
}

class _MapaCompletoScreenState extends State<MapaCompletoScreen> {
  final mapa = new MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Container(
        color: Colors.blue,
        child: ListView(
          children: [
            DrawerHeader(
                child: Center(
              child: Text(
                "INCIDENCIAS DE CARRETERAS EN NAVARRA",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            )
                // child: FadeInImage(
                //   placeholder: AssetImage("assets/images/cabecera_menu.jpg"),
                //   image: AssetImage("assets/images/cabecera_menu.jpg"),
                //   fit: BoxFit.cover,
                // ),
                ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              trailing: Icon(Icons.home, color: Colors.white),
              title: Text(
                "Inicio",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Get.offAll(ListIncidenciasSwiperScreen());
              },
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              tileColor: Colors.white,
              trailing: Icon(Icons.map, color: Colors.blue),
              title: Text(
                "Ver mapa con todas las incidencias",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pop(
                //   context,
                //   MaterialPageRoute(builder: (context) => MapaCompletoScreen()),
                // );
              },
            ),
            Divider(
              color: Colors.white,
            ),
          ],
        ),
      )),
      appBar: AppBar(
        title: Text("Mapa de incidencias"),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
                child: _start(),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.864),
          ),
        ],
      ),
    );
  }

  Widget _start() {
    return FutureBuilder(
      future: incidenciasProvider.cargarIncidencias(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _mapaFlutter(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _mapaFlutter(data) {
    return new FlutterMap(
      mapController: mapa,
      options: new MapOptions(
        center: new LatLng(42.306483, -1.615145),
        zoom: 8.0,
      ),
      layers: [
        _mapa(),
        _markers(data),
      ],
    );
  }

  _mapa() {
    return new TileLayerOptions(
      urlTemplate: "https://api.tiles.mapbox.com/v4/"
          "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
      additionalOptions: {
        'accessToken':
            'pk.eyJ1IjoiY2ppbWVuZWN1ZSIsImEiOiJja2dqNmNmbmkwNGlzMnNtbnRnZ3lhbmdvIn0.9-cq2z84m8a2iqNHYyMBHw',
        'id': 'mapbox.streets',
      },
    );
  }

  _markers(data) {
    List<Marker> lst = [];
    data.forEach((ic) {
      var latlon = UTM.fromUtm(
        easting: double.parse(ic.coordXEnEpsg25830),
        northing: double.parse(ic.coordYEnEpsg25830),
        zoneNumber: 30,
        zoneLetter: "N",
      );
      final w = Marker(
        width: 50.0,
        height: 50.0,
        point: new LatLng(latlon.lat, latlon.lon),
        builder: (ctx) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MapaInfoScreen(incidencia: ic)),
            );
          },
          child: new Container(
            child: Icon(
              Icons.dangerous,
              color: Colors.red,
              size: 40,
            ),
          ),
        ),
      );
      lst.add(w);
    });
    return new MarkerLayerOptions(
      markers: lst,
    );
  }
}
