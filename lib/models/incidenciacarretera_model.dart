// To parse this JSON data, do
//
//     final incidenciaCarretera = incidenciaCarreteraFromJson(jsonString);

import 'dart:convert';

IncidenciaCarretera incidenciaCarreteraFromJson(String str) =>
    IncidenciaCarretera.fromJson(json.decode(str));

String incidenciaCarreteraToJson(IncidenciaCarretera data) =>
    json.encode(data.toJson());

class IncidenciaCarretera {
  //final _dir = "assets/images/local/";

  //getImgPath() {
  //  return _dir + this.carretera.split("-")[0];
  //}

  IncidenciaCarretera({
    this.ultimaActualizacion,
    this.titulo,
    this.ubicacion,
    this.fechaIncidencia,
    this.gravedad,
    this.afeccion,
    this.categoria,
    this.tipo,
    this.otrosDatos,
    this.coordXEnEpsg25830,
    this.coordYEnEpsg25830,
    this.carretera,
    this.pk,
  });

  String ultimaActualizacion;
  String titulo;
  String ubicacion;
  String fechaIncidencia;
  String gravedad;
  String afeccion;
  String categoria;
  String tipo;
  String otrosDatos;
  String coordXEnEpsg25830;
  String coordYEnEpsg25830;
  String carretera;
  String pk;

  factory IncidenciaCarretera.fromJson(Map<String, dynamic> json) =>
      IncidenciaCarretera(
        ultimaActualizacion: json["Ultima_actualizacion"],
        titulo: json["Titulo"],
        ubicacion: json["Ubicacion"],
        fechaIncidencia: json["Fecha_incidencia"],
        gravedad: json["Gravedad"],
        afeccion: json["Afeccion"],
        categoria: json["Categoria"],
        tipo: json["Tipo"],
        otrosDatos: json["Otros_datos"],
        coordXEnEpsg25830: json["Coord_X_en_EPSG_25830"],
        coordYEnEpsg25830: json["Coord_Y_en_EPSG_25830"],
        carretera: json["Carretera"],
        pk: json["PK"],
      );

  Map<String, dynamic> toJson() => {
        "Ultima_actualizacion": ultimaActualizacion,
        "Titulo": titulo,
        "Ubicacion": ubicacion,
        "Fecha_incidencia": fechaIncidencia,
        "Gravedad": gravedad,
        "Afeccion": afeccion,
        "Categoria": categoria,
        "Tipo": tipo,
        "Otros_datos": otrosDatos,
        "Coord_X_en_EPSG_25830": coordXEnEpsg25830,
        "Coord_Y_en_EPSG_25830": coordYEnEpsg25830,
        "Carretera": carretera,
        "PK": pk,
      };
}
