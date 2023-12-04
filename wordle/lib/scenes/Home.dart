import 'package:flutter/material.dart';
import 'Wordle.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Wordle Game'),
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
            Image.asset(
              'assets/images/elige_una_tematica.PNG',
            ),
            /*Text(
              'Bienvenido a Wordle!',
              style: TextStyle(fontSize: 20),
            ),*/
            SizedBox(height: 15),

            GestureDetector(
              onTap:(){
                Navigator.pushNamed(
                    context,
                    '/wordle', // Usa Wordle en lugar de Worldle
                    arguments: {'lista': 0}
                );
              },
              child:Column (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200, // Ancho deseado
                     child: Image.asset(
                       'assets/images/comida.PNG', // Ruta de la imagen
                      fit: BoxFit.contain, // Ajuste de la imagen para que quepa en el contenedor
                     ),
                  )
                ],
              )
            ),
            SizedBox(height: 10),
            GestureDetector(
                onTap:(){
                  Navigator.pushNamed(
                      context,
                      '/wordle', // Usa Wordle en lugar de Worldle
                      arguments: {'lista': 1}
                  );
                },
                child:Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200, // Ancho deseado
                      child: Image.asset(
                        'assets/images/animales.PNG', // Ruta de la imagen
                        fit: BoxFit.contain, // Ajuste de la imagen para que quepa en el contenedor
                      ),
                    )
                  ],
                )
            ),
            SizedBox(height: 10),
            GestureDetector(
                onTap:(){
                  Navigator.pushNamed(
                      context,
                      '/wordle', // Usa Wordle en lugar de Worldle
                      arguments: {'lista': 2}
                  );
                },
                child:Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200, // Ancho deseado
                      child: Image.asset(
                        'assets/images/oceano.PNG', // Ruta de la imagen
                        fit: BoxFit.contain, // Ajuste de la imagen para que quepa en el contenedor
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}