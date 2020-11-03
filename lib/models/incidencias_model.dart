import 'incidenciacarretera_model.dart';

class Incidencias {
  List<IncidenciaCarretera> listaIncidencias = new List();
  Incidencias.fromJsonList(List<dynamic> listaJson) {
    if (listaJson == null) return;
    listaJson.forEach((json) {
      final incidencia = IncidenciaCarretera.fromJson(json);
      listaIncidencias.add(incidencia);
    });
  }
}
