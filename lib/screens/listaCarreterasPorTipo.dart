import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:info_carreteras_navarra/providers/incidencias_provider.dart';
import 'package:info_carreteras_navarra/screens/listaIncidenciasPorCarretera.dart';
import 'package:info_carreteras_navarra/screens/listview_screen.dart';

import 'mapa_info_screen.dart';

class ListaCarreterasPorTipo extends StatelessWidget {
  final box = GetStorage();
  final String tipo;

  ListaCarreterasPorTipo({@required this.tipo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carreteras por Tipo'),
      ),
      body: _lista(context),
    );
  }

  Widget _lista(context) {
    return FutureBuilder(
      future: incidenciasProvider.cargarCarreterasTipo(tipo),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            children: _listaElementos(snapshot.data, context),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _listaElementos(List<String> data, context) {
    final List<Widget> lst = [];
    data.forEach((ic) {
      final w = ListTile(
        title: Text(
          ic,
          style: TextStyle(fontSize: 18),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () async {
          box.write("carretera", ic);
          //print(lista[index]);
          var incidencias =
              await incidenciasProvider.cargarIncidenciasFiltradas(ic);
          if (incidencias.length == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MapaInfoScreen(incidencia: incidencias[0])));
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ListaIncidenciasPorCarretera(carretera: ic)),
            );
          }
        },
      );
      lst.add(w);
      lst.add(Divider());
    });
    return lst;
  }
}
