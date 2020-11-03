import 'package:flutter/material.dart';

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
      future: Incidencias_Provider.cargarPuntos(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            children: _listaElementos(snapshot.data),
          )
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  List<Widget>_listaElementos(List<IncidenciaCarretera> data) {
    final List<Widget> lst = [];
    data.forEach((ic) { 
      final w = ListTitle(
        title: Text(ic.incidencia),
      subtitle: Text(ic.carretera),
      );
    });
    lst.add(w);
    lst.add(Divider());
    return lst;
  }
}
