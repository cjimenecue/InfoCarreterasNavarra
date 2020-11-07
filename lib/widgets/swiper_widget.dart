import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:info_carreteras_navarra/models/incidenciacarretera_model.dart';
import 'package:info_carreteras_navarra/models/incidencias_model.dart';
import 'package:info_carreteras_navarra/screens/listaCarreterasPorTipo.dart';
import 'package:info_carreteras_navarra/screens/listincidencias_screen.dart';

class SwiperWidget extends StatelessWidget {
  final List<String> lista;

  SwiperWidget({@required this.lista});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _swiper(context),
    );
  }

  Widget _swiper(context) {
    final tamanoPantalla = MediaQuery.of(context).size;
    return Swiper(
      itemHeight: tamanoPantalla.height * 0.9,
      itemWidth: tamanoPantalla.width * 0.8,
      layout: SwiperLayout.CUSTOM,
      customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
          .addRotate([-45.0 / 180, 0.0, 45.0 / 180]).addTranslate(
              [Offset(-370.0, -40.0), Offset(0.0, 0.0), Offset(370.0, -40.0)]),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            //print(lista[index]);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListaCarreterasPorTipo(tipo: lista[index])),);
          },
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: FadeInImage(
                    placeholder: AssetImage("assets/images/road.jpg"),
                    image: AssetImage(
                        "assets/images/local/" + lista[index] + ".jpg"),
                    fit: BoxFit.cover,
                  )),
              Text(
                lista[index],
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
      itemCount: lista.length,
      pagination: new SwiperPagination(),
      control: new SwiperControl(),
    );
  }
}
