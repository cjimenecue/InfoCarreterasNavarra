import 'package:flutter/material.dart';
import 'package:info_carreteras_navarra/models/incidenciacarretera_model.dart';
import 'package:info_carreteras_navarra/providers/incidencias_provider.dart';

class ListaTiposCarretera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Tipos de carretera con incidencia")),
        body: _lista());
  }

  Widget _lista() {
    return FutureBuilder(
      future: incidenciasProvider.cargarTiposCarretera(),
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(children: _listaElementos(snapshot.data));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  List<Widget> _listaElementos(List<String> data) {
    final List<Widget> lst = [];
    data.forEach((c) {
      final w = ListTile(
        title: Text(c),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {},
      );
      lst.add(w);
      lst.add(Divider());
    });
    return lst;
  }
}
