import 'package:flutter/material.dart';
import 'package:wordle/scenes/Derrota.dart';
import 'package:wordle/scenes/Victoria.dart';
import 'package:wordle/scenes/Wordle.dart';
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
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/wordle': (context) => Wordle(),
        '/victory': (context) => Victoria(),
        '/defeat': (context) => Derrota()
      },
      // Establece la página de inicio como la página inicial de la aplicación
    );
  }
}