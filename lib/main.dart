import 'package:flutter/material.dart';
import 'package:info_carreteras_navarra/screens/listincidencias_screen.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: ListIncidenciasScreen(),
    );
  }
}