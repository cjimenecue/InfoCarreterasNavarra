import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {
  final listaTipos = [
    "Carretera Nacional",
    "Autopista",
    "Autovia"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView Screen"),
      ),
      body: ListView(
        children: [
          _listaElementos(),
        ],
      ),
    );
  }

  List<Widget>_listaElementos() {
    List<Widget> lista = [];
    listaTipos.forEach((tipo) { 
      final title = new ListTile(
        title: Text(tipo),
      );
      lista.add(title);
      lista.add(Divider());
    });
    return lista;
  }
}
