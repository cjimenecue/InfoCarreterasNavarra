import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:info_carreteras_navarra/models/incidenciacarretera_model.dart';
import 'package:info_carreteras_navarra/models/incidencias_model.dart';

class IncidenciasProvider {
  List<IncidenciaCarretera> listaIncidencias = [];

  Future<List<IncidenciaCarretera>> cargarIncidencias() async {
    final datos =
        await rootBundle.loadString("assets/data/IncidenciasdeCarreteras.json");
    final datosDecodificados = json.decode(datos);
    final openData = datosDecodificados["OpenData"];
    final openDataRow = openData["OpenDataRow"];
    Incidencias incidencias = Incidencias.fromJsonList(openDataRow);
    listaIncidencias = incidencias.listaIncidencias;
    return listaIncidencias;
  }
}
