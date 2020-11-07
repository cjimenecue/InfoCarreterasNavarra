import 'package:flutter/material.dart';
import 'package:info_carreteras_navarra/providers/incidencias_provider.dart';
import 'package:info_carreteras_navarra/screens/listview_screen.dart';

class ListaCarreterasPorTipo extends StatelessWidget {
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
        title: Text(ic, style: TextStyle(fontSize: 18),),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
            //print(lista[index]);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaTiposCarretera()),);
                    //builder: (context) => ListaIncidenciasPorCarretera(carretera: ic)),);
          },
      );
      lst.add(w);
      lst.add(Divider());
    });
    return lst;
  }
}
