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
            Text(
              'Bienvenido a Wordle!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la página de juego cuando se presiona el botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Wordle()), // Usa Wordle en lugar de Worldle
                );
              },
              child: Text('Iniciar Juego'),
            ),
          ],
        ),
      ),
    );
  }
}