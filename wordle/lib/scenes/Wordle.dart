import 'package:flutter/material.dart';
import 'package:wordle/Logica/LogicaWordle.dart';

class Wordle extends StatefulWidget {
  @override
  _WordleState createState() => _WordleState();
}

class _WordleState extends State<Wordle> {
  WordleGame _wordleGame = WordleGame();
  String _currentInput = '';

  List<List<LetterSquare>> letterSquareGrid = List.generate(
    6, (row) =>
      List.generate(
        5, (col) => LetterSquare(Colors.grey, ''),
      ),
  );

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
            // Mostrar las filas de cuadrados
            for (List<LetterSquare> row in letterSquareGrid)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row,
              ),
            // Mostrar el teclado personalizado
            buildKeyboard(),
            Text('Conjeturas anteriores: ${_wordleGame.previousGuesses.join(', ')}'),
            Text('Intentos restantes: ${_wordleGame.maxAttempts - _wordleGame.previousGuesses.length}'),
          ],
        ),
      ),
    );
  }

  Widget buildKeyboard() {
    return Column(
      children: [
        buildRow(['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P']),
        buildRow(['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L']),
        buildRow(['Z', 'X', 'C', 'V', 'B', 'N', 'M']),
        buildRow([' ', 'Delete', 'Submit']),
      ],
    );
  }

  Widget buildRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((key) => buildKeyButton(key)).toList(),
    );
  }

  Widget buildKeyButton(String key) {
    return ElevatedButton(
      onPressed: () {
        handleKey(key);
      },
      child: Text(key),
    );
  }

  void updateSquareColor(int row, int col, Color newColor) {
    setState(() {
      letterSquareGrid[row][col] = LetterSquare(newColor, _currentInput[col]);
    });
  }

  void handleKey(String key) {
    setState(() {
      if (key == 'Delete' && _currentInput.isNotEmpty) {
        _currentInput = _currentInput.substring(0, _currentInput.length - 1);
      } else if (key == 'Submit' && _currentInput.length == 5) {
        _wordleGame.submitGuess(context, _currentInput);
        _updateSquares();

        _currentInput = '';
      } else if (key != 'Delete' && key != 'Submit' && _currentInput.length < 5) {
        _currentInput += key;
        //_updateSquares();
      }
    });
  }


  void _updateSquares() {
    int currentAttemptIndex = _wordleGame.currentAttempt -1;

    for (int i = 0; i < 5; i++) {
      if (i < _wordleGame.targetWord.length) {
        String targetLetter = _wordleGame.targetWord[i];

        if (i < _currentInput.length) {
          String guessedLetter = _currentInput[i];

          if (guessedLetter == targetLetter) {
            //letterSquareGrid[currentAttemptIndex][i].updateColor(Colors.green);
            updateSquareColor(currentAttemptIndex, i, Colors.green);
          } else if (_wordleGame.targetWord.contains(guessedLetter) &&
              _wordleGame.targetWord.indexOf(guessedLetter) != i) {
            //letterSquareGrid[currentAttemptIndex][i].updateColor(Colors.yellow);
            updateSquareColor(currentAttemptIndex, i, Colors.yellow);
          } else {
            updateSquareColor(currentAttemptIndex, i, Colors.grey);
            //letterSquareGrid[currentAttemptIndex][i].updateColor(Colors.grey);
          }
        }
      }
    }
  }
}

class LetterSquare extends StatelessWidget {
  Color colorL;
  String letterL = '';

  LetterSquare(this.colorL, this.letterL);

  void updateColor(Color newColor) {

      colorL = newColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      color: colorL,
      margin: EdgeInsets.all(5),
      child: Center(
        child: Text(
          letterL,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}

