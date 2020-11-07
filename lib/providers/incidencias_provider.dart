import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:info_carreteras_navarra/models/incidenciacarretera_model.dart';
import 'package:info_carreteras_navarra/models/incidencias_model.dart';

class IncidenciasProvider {
  List<IncidenciaCarretera> listaIncidencias = [];
  List<String> listaTiposCarretera = [];
  List<String> listaCarreteraTipo = [];

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

  Future<List<String>> cargarTiposCarretera() async {
    if (listaIncidencias.length == 0) {
      await cargarIncidencias();
    }
    listaTiposCarretera = [];
    listaIncidencias.forEach((cr) {
      if (listaTiposCarretera.indexOf(cr.carretera.split("-")[0]) < 0) {
        listaTiposCarretera.add(cr.carretera.split("-")[0]);
      }
    });
    return listaTiposCarretera;
  }

  Future<List<String>> cargarCarreterasTipo(String tipo) async {
    if (listaIncidencias.length == 0) {
      await cargarIncidencias();
    }
    listaCarreteraTipo = [];
    listaIncidencias.forEach((cr) {
      if (listaCarreteraTipo.indexOf(cr.carretera) < 0)  {
          if(cr.carretera.split("-")[0] == tipo){
            listaCarreteraTipo.add(cr.carretera);
          }
      }
    });
    return listaCarreteraTipo;
  }
}

final incidenciasProvider = new IncidenciasProvider();
