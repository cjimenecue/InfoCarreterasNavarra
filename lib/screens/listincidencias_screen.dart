import 'package:flutter/material.dart';
import 'package:info_carreteras_navarra/models/incidenciacarretera_model.dart';
import 'package:info_carreteras_navarra/providers/incidencias_provider.dart';

class ListIncidenciasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListIncidencias Screen'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: incidenciasProvider.cargarIncidencias(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            children: _listaElementos(snapshot.data),
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  List<Widget>_listaElementos(List<IncidenciaCarretera> data) {
    final List<Widget> lst = [];
    data.forEach((ic) { 
      final w = ListTile(
        title: Text(ic.ubicacion),
        subtitle: Text(ic.otrosDatos),
      );
      lst.add(w);
      lst.add(Divider());
    });
    return lst;
  }
}
