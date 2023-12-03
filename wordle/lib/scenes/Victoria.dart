import 'package:flutter/material.dart';
import 'Home.dart';


class Victoria extends StatefulWidget {
  @override
  _VictoriaState createState() => _VictoriaState();
}

class _VictoriaState extends State<Victoria> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('¡Enhorabuena!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Enhorabuena!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar a la escena de inicio cuando se presiona el botón
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Text('Ir a la pantalla de inicio'),
            ),
          ],
        ),
      ),
    );
  }
}