import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:info_carreteras_navarra/screens/listincidencias_screen.dart';
import 'package:info_carreteras_navarra/screens/listincidencias_swiper_screen.dart';
import 'package:info_carreteras_navarra/screens/listview_screen.dart';

//void main() => runApp(MyApp());
main() async {
  await GetStorage.init();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Incidencias Carreteras Navarra',
      home: ListIncidenciasSwiperScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
