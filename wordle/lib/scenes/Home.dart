import 'package:flutter/material.dart';
import 'Wordle.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wordle Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
            'assets/images/Wordle_logo.png',
            ),
            /*Text(
              'Bienvenido a Wordle!',
              style: TextStyle(fontSize: 20),
            ),*/
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la página de juego cuando se presiona el botón
                Navigator.pushNamed(
                  context,
                  '/wordle', // Usa Wordle en lugar de Worldle
                  arguments: {'lista': 0}
                );
              },
              child: Text('Tematica: Comida'),
            ),
            ElevatedButton(
             onPressed: () {
               // Navegar a la página de juego cuando se presiona el botón
               Navigator.pushNamed(
                    context,
                    '/wordle', // Usa Wordle en lugar de Worldle
                    arguments: {'lista': 1}
                );
              },
              child: Text('Tematica: Animales'),
            ),
            ElevatedButton(
             onPressed: () {
                // Navegar a la página de juego cuando se presiona el botón
                Navigator.pushNamed(
                    context,
                    '/wordle', // Usa Wordle en lugar de Worldle
                    arguments: {'lista': 2}
                );
              },
              child: Text('Tematica: Océano'),
            ),
          ],
        ),
      ),
    );
  }
}