import 'package:flutter/material.dart';
import 'scenes/Home.dart'; // Importa la página de inicio que has creado

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Home(), // Establece la página de inicio como la página inicial de la aplicación
    );
  }
}