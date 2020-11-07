import 'package:flutter/material.dart';
import 'package:info_carreteras_navarra/models/incidenciacarretera_model.dart';
import 'package:info_carreteras_navarra/providers/incidencias_provider.dart';
import 'package:info_carreteras_navarra/screens/listview_screen.dart';

class ListaIncidenciasPorCarretera extends StatelessWidget {
  final String carretera;
  
  ListaIncidenciasPorCarretera({@required this.carretera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incidencias'),
      ),
      body: _lista(context),
    );
  }

  Widget _lista(context) {
    return FutureBuilder(
      future: incidenciasProvider.cargarIncidenciasFiltradas(carretera),
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

  _listaElementos(List<IncidenciaCarretera> data, context) {
    final List<Widget> lst = [];
    data.forEach((ic) { 
      final w = ListTile(
        title: Text(ic.ubicacion, style: TextStyle(fontSize: 18),),
        subtitle: Text(ic.otrosDatos),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
            //print(lista[index]);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaTiposCarretera()),);
                    //builder: (context) => MapaInfoScreen(incidencia: ic)),);
          },
      );
      lst.add(w);
      lst.add(Divider());
    });
    return lst;
  }
}
