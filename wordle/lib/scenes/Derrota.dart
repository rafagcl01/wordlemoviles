import 'package:flutter/material.dart';
import 'Home.dart'; // Ajusta la ruta de importación según tu estructura de archivos
import 'package:wordle/Logica/LogicaWordle.dart';

class Derrota extends StatefulWidget {
  @override
  _DerrotaState createState() => _DerrotaState();
}

class _DerrotaState extends State<Derrota> {

  late String targetWord;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();

    Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    targetWord = arguments['word'] ?? 'palabra';

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('¡Lo siento, vuelve a intentarlo!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Lo siento, vuelve a intentarlo!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'la palabra correcta era: ${targetWord}' ,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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