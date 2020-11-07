import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:info_carreteras_navarra/models/incidenciacarretera_model.dart';
import 'package:utm/utm.dart';
import 'package:latlong/latlong.dart';

class MapaInfoScreen extends StatefulWidget {
  final IncidenciaCarretera incidencia;
  MapaInfoScreen({@required this.incidencia});

  @override
  _MapaInfoScreenState createState() =>
      _MapaInfoScreenState(incidencia: incidencia);
}

class _MapaInfoScreenState extends State<MapaInfoScreen> {
  final IncidenciaCarretera incidencia;
  final mapa = new MapController();
  var latlon;

  _MapaInfoScreenState({@required this.incidencia}) {
    latlon = latlon = UTM.fromUtm(
      easting: double.parse(incidencia.coordXEnEpsg25830),
      northing: double.parse(incidencia.coordYEnEpsg25830),
      zoneNumber: 30,
      zoneLetter: "N",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Información de la incidencia")),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          _info(context),
          SizedBox(
            height: 20,
          ),
          Container(
              child: _mapaFlutter(),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5),
        ],
      ),
    );
  }

  Widget _info(context) {
    return Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.29729,
        child: ListView(
          children: [
            Text(
              incidencia.ubicacion,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ));
  }

  Widget _mapaFlutter() {
    return new FlutterMap(
      mapController: mapa,
      options: new MapOptions(
        center: new LatLng(latlon.lat, latlon.lon),
        zoom: 18.0,
      ),
      layers: [
        _mapa(),
        _markers(),
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
        'id': 'mapbox.satellite',
      },
    );
  }

  _markers() {
    return new MarkerLayerOptions(
      markers: [
        new Marker(
          width: 50.0,
          height: 50.0,
          point: new LatLng(latlon.lat, latlon.lon),
          builder: (ctx) => new Container(
            child: Icon(
              Icons.dangerous,
              color: Colors.red,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}
