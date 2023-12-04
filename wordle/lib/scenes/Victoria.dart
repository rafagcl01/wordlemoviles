import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:wordle/Logica/LogicaWordle.dart';


class Victoria extends StatefulWidget {
  @override
  _VictoriaState createState() => _VictoriaState();
}

class _VictoriaState extends State<Victoria> {
  late ConfettiController _confettiController;
  late String targetWord;

@override
  void didChangeDependencies(){
    super.didChangeDependencies();

    Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    targetWord = arguments['word'] ?? 'palabra';

  }


  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    // Llama a la función que activa el confeti al inicio
    _activateConfetti();
  }

  // Función para activar el confeti
  void _activateConfetti() {
    _confettiController.play();
  }

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
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              maxBlastForce: 5, // Ajusta según sea necesario
              minBlastForce: 2, // Ajusta según sea necesario
              emissionFrequency: 0.2, // Ajusta según sea necesario
            ),
            Text(
              '¡Enhorabuena!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'la palabra correcta es: ${targetWord}' ,
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