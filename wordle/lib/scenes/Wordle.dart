import 'package:flutter/material.dart';
import 'package:wordle/Logica/LogicaWordle.dart';


class Wordle extends StatefulWidget {
  @override
  _WordleState createState() => _WordleState();
}

class _WordleState extends State<Wordle> {
  WordleGame _wordleGame = WordleGame(); // Instancia de WordleGame para gestionar la lógica del juego
  TextEditingController _guessController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wordle Game - Juego'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Adivina la palabra de 5 letras!',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _guessController,
              decoration: InputDecoration(labelText: 'Introduce tu conjetura'),
            ),
            ElevatedButton(
              onPressed: () {
                String result = _wordleGame.submitGuess(_guessController.text);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(result),
                ));
                _guessController.clear();
                setState(() {});
              },
              child: Text('Hacer Conjetura'),
            ),
            Text('Conjeturas anteriores: ${_wordleGame.previousGuesses.join(', ')}'),
            Text('Intentos restantes: ${_wordleGame.maxAttempts - _wordleGame.previousGuesses.length}'),
          ],
        ),
      ),
    );
  }
}