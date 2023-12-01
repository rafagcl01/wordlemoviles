import 'package:flutter/material.dart';
import 'package:wordle/Logica/LogicaWordle.dart';

class Wordle extends StatefulWidget {
  @override
  _WordleState createState() => _WordleState();
}

class _WordleState extends State<Wordle> {
  WordleGame _wordleGame = WordleGame();
  TextEditingController _guessController = TextEditingController();

  List<List<Color>> _rowColors = List.generate(6, (index) => List.filled(5, Colors.grey));

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
                _updateRowColors();
                String result = _wordleGame.submitGuess(context, _guessController.text);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(result),
                ));
                _guessController.clear();
                setState(() {});
              },
              child: Text('Hacer Conjetura'),
            ),
            // Mostrar las filas de cuadrados
            for (int i = 0; i < 6; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _generateRowColors(i),
              ),
            Text('Conjeturas anteriores: ${_wordleGame.previousGuesses.join(', ')}'),
            Text('Intentos restantes: ${_wordleGame.maxAttempts - _wordleGame.previousGuesses.length}'),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateRowColors(int rowIndex) {
    List<Widget> letterSquares = [];

    for (int i = 0; i < 5; i++) {
      Color squareColor = _rowColors[rowIndex][i];

      letterSquares.add(Container(
        width: 30,
        height: 30,
        color: squareColor,
        margin: EdgeInsets.all(5),
      ));
    }

    return letterSquares;
  }

  void _updateRowColors() {
    // Actualizar solo si la longitud de la palabra introducida es la misma que la palabra objetivo
    if (_guessController.text.length == _wordleGame.targetWord.length) {
      for (int i = 0; i < 6; i++) {
        _rowColors[i] = _getSquareColorsForRow(i);
      }
    }
  }

  List<Color> _getSquareColorsForRow(int rowIndex) {
    List<Color> colors = [];

    for (int i = 0; i < 5; i++) {
      Color squareColor = Colors.grey;

      if (i < _wordleGame.targetWord.length) {
        String targetLetter = _wordleGame.targetWord[i];

        if (i < _guessController.text.length) {
          String guessedLetter = _guessController.text[i];

          if (guessedLetter == targetLetter) {
            squareColor = Colors.green;
          } else if (_wordleGame.targetWord.contains(guessedLetter)) {
            squareColor = Colors.yellow;
          }
        }
      }

      colors.add(squareColor);
    }

    return colors;
  }
}