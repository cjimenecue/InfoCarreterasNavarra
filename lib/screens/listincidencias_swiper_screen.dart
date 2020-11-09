import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_carreteras_navarra/providers/incidencias_provider.dart';
import 'package:info_carreteras_navarra/screens/mapa_completo_screen.dart';
import 'package:info_carreteras_navarra/widgets/swiper_widget.dart';

class ListIncidenciasSwiperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Container(
        color: Colors.blue,
        child: ListView(
          children: [
            DrawerHeader(
                child: Center(
              child: Text(
                "INCIDENCIAS DE CARRETERAS EN NAVARRA",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            )
                // child: FadeInImage(
                //   placeholder: AssetImage("assets/images/cabecera_menu.jpg"),
                //   image: AssetImage("assets/images/cabecera_menu.jpg"),
                //   fit: BoxFit.cover,
                // ),
                ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              tileColor: Colors.white,
              trailing: Icon(Icons.home, color: Colors.blue),
              title: Text(
                "Inicio",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              trailing: Icon(Icons.map, color: Colors.white),
              title: Text(
                "Ver mapa con todas las incidencias",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Get.offAll(MapaCompletoScreen());
                // Navigator.pop(
                //   context,
                //   MaterialPageRoute(builder: (context) => MapaCompletoScreen()),
                // );
              },
            ),
            Divider(
              color: Colors.white,
            ),
          ],
        ),
      )),
      appBar: AppBar(
        title: Text('TIPOS DE CARRETERA'),
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
