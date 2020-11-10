import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:info_carreteras_navarra/providers/incidencias_provider.dart';
import 'package:info_carreteras_navarra/screens/listaIncidenciasPorCarretera.dart';
import 'package:info_carreteras_navarra/screens/mapa_completo_screen.dart';
import 'package:info_carreteras_navarra/screens/mapa_info_screen.dart';
import 'package:info_carreteras_navarra/widgets/swiper_widget.dart';

class ListIncidenciasSwiperScreen extends StatelessWidget {
  final box = GetStorage();
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
        actions: [
          Builder(
            builder: (context) => Container(
              margin: EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: Icon(
                  Icons.update,
                  //child: Icon(Icons.update),
                ),
                onTap: () {
     
                  if(box.read("carretera") == null){
                    var snacknull = SnackBar(
                    content: Text("No hay datos leidos"),
                  );
                    Scaffold.of(context).showSnackBar(snacknull);

                  }else{
                    var snackBar = SnackBar(
                    action: SnackBarAction(
                        label: 'abrir',
                        onPressed: () {
                          _carreteraReciente(context);
                        },
                      ),
                    content: Text("Último dato leído: " + box.read("carretera")),
                  );
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                },
              ),
            ),
          ),
        ],
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

  void _carreteraReciente(context) async {
    var incidencias =
      await incidenciasProvider.cargarIncidenciasFiltradas(box.read("carretera"));
    if (incidencias.length == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                MapaInfoScreen(incidencia: incidencias[0])));
    } else if (incidencias.length == 0){
      final snackBar = SnackBar(
        content: Text("No hay incidencias de la carretera " + box.read("carretera")),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } 
    else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
              ListaIncidenciasPorCarretera(carretera: box.read("carretera"))),
      );
    }
  }
}
