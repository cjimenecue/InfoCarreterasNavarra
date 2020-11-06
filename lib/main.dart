import 'package:flutter/material.dart';
import 'package:info_carreteras_navarra/screens/listincidencias_screen.dart';
import 'package:info_carreteras_navarra/screens/listincidencias_swiper_screen.dart';
import 'package:info_carreteras_navarra/screens/listview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Incidencias Carreteras Navarra',
      home: ListIncidenciasSwiperScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
