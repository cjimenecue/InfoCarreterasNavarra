// To parse this JSON data, do
//
//     final puntoReciclajr = puntoReciclajrFromJson(jsonString);

import 'dart:convert';

PuntoReciclajr puntoReciclajrFromJson(String str) =>
    PuntoReciclajr.fromJson(json.decode(str));

String puntoReciclajrToJson(PuntoReciclajr data) => json.encode(data.toJson());

class PuntoReciclajr {
  PuntoReciclajr({
    this.ultimaActualizacion,
    this.titulo,
    this.ubicacion,
    this.fechaIncidencia,
    this.gravedad,
    this.afeccion,
    this.categoria,
    this.tipo,
    this.otrosDatos,
    this.coordX,
    this.coordY,
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
  String coordX;
  String coordY;
  String carretera;
  String pk;

  factory PuntoReciclajr.fromJson(Map<String, dynamic> json) => PuntoReciclajr(
        ultimaActualizacion: json["Ultima_actualizacion"],
        titulo: json["Titulo"],
        ubicacion: json["Ubicacion"],
        fechaIncidencia: json["Fecha_incidencia"],
        gravedad: json["Gravedad"],
        afeccion: json["Afeccion"],
        categoria: json["Categoria"],
        tipo: json["Tipo"],
        otrosDatos: json["Otros_datos"],
        coordX: json["Coord_X_en_EPSG_25830"],
        coordY: json["Coord_Y_en_EPSG_25830"],
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
        "Coord_X_en_EPSG_25830": coordX,
        "Coord_Y_en_EPSG_25830": coordY,
        "Carretera": carretera,
        "PK": pk,
      };
}
