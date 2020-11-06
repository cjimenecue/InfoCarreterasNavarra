import 'package:flutter/material.dart';
import 'package:info_carreteras_navarra/providers/incidencias_provider.dart';
import 'package:info_carreteras_navarra/widgets/swiper_widget.dart';

class ListIncidenciasSwiperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('TIPOS DE CARRETERA')),
      ),
      body: _swiper(),
    );
  }

  Widget _swiper() {
    return FutureBuilder(
      future: incidenciasProvider.cargarTiposCarretera(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SwiperWidget(lista: snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
