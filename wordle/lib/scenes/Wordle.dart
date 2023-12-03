import 'package:flutter/material.dart';
import 'package:wordle/Logica/LogicaWordle.dart';

class Wordle extends StatefulWidget {
  @override
  _WordleState createState() => _WordleState();
}

class _WordleState extends State<Wordle> {
  WordleGame _wordleGame = WordleGame();
  TextEditingController _guessController = TextEditingController();

  //rowColors ya no se usa
  List<List<Color>> _rowColors = List.generate(
      6, (index) => List.filled(5, Colors.grey));
  int _currentRow = 0; // Variable para realizar un seguimiento de la fila actual

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
            TextField(
              controller: _guessController,
              decoration: InputDecoration(labelText: 'Introduce tu conjetura'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateRow();
                String result = _wordleGame.submitGuess(
                    context, _guessController.text);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(result),
                ));
                _guessController.clear();
                setState(() {});
              },
              child: Text('Hacer Conjetura'),
            ),
            // Mostrar las filas de cuadrados

            for (List<LetterSquare> row in letterSquareGrid)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row,
              ),
            Text('Conjeturas anteriores: ${_wordleGame.previousGuesses.join(
                ', ')}'),
            Text('Intentos restantes: ${_wordleGame.maxAttempts -
                _wordleGame.previousGuesses.length}'),
          ],
        ),
      ),
    );
  }

//ya no se usa
  List<Widget> _generateRowColors(int rowIndex) {
    List<LetterSquare> letterSquares = [];

    for (int i = 0; i < 5; i++) {
      Color squareColor = _rowColors[rowIndex][i];
      letterSquares[i].colorL = squareColor;
      /*
      letterSquares.add(
          Container(
        width: 30,
        height: 30,
        color: squareColor,
        margin: EdgeInsets.all(5),
            child: Center(
              child: Text(
                '',  // Puedes cambiar 'A' por la letra que deseas asignar dinámicamente
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
      ));
      */
    }

    return letterSquares;
  }

  //actualiza la fila cuando se introduce una letra
  void _updateRow() {
    // Actualizar solo si la longitud de la palabra introducida es la misma que la palabra objetivo

    if (_guessController.text.length == _wordleGame.targetWord.length) {
      //_rowColors[_currentRow] = _getSquareColorsForRow(_currentRow);
      _updateSquares(_currentRow);
      _currentRow = (_currentRow + 1) % 6; // Mover a la siguiente fila circularmente

      setState(() {}); // Asegurarse de que el cambio de estado se refleje en la interfaz de usuario
    }
  }

//actualiza los bloques cambiando color y la letra
  void _updateSquares(int rowIndex) {
    if (_guessController.text.length == _wordleGame.targetWord.length) {

      //pruebas para solucionar el error de las letras repes
      /*
      // Utilizamos un Map para llevar un recuento de las letras
      Map<String, int> recuentoLetras = {};
      // Iteramos sobre cada letra en la palabra
      for (int i = 0; i < _wordleGame.targetWord.length; i++) {
        String letter = _wordleGame.targetWord[i];

        // Verificamos si la letra ya está en el Map
        if (recuentoLetras.containsKey(letter)) {
          // Si la letra ya está, incrementamos su contador
          recuentoLetras[letter] += 1;
        } else {
          // Si la letra no está, la añadimos al Map con un contador de 1
          recuentoLetras[letter] = 1;
        }
      }*/

      for (int i = 0; i < 5; i++) {

        if (i < _wordleGame.targetWord.length) {
          String targetLetter = _wordleGame.targetWord[i];

          if (i < _guessController.text.length) {
            String guessedLetter = _guessController.text[i];
            //letterSquareGrid[rowIndex][i].letterL = guessedLetter;

            if (guessedLetter == targetLetter) {
              // Cambiar a verde solo si la letra coincide en posición
              letterSquareGrid[rowIndex][i]= LetterSquare(Colors.green, guessedLetter);
            } else if (_wordleGame.targetWord.contains(guessedLetter) &&
                _wordleGame.targetWord.indexOf(guessedLetter) != i) {

              // Cambiar a amarillo solo si la letra está en la palabra pero no en la posición correcta
              letterSquareGrid[rowIndex][i]= LetterSquare(Colors.yellow, guessedLetter);
            } else{
              letterSquareGrid[rowIndex][i]= LetterSquare(Colors.grey, guessedLetter);
            }
          }
        }
      }

    }
  }

  //ya no se usa
    List<Color> _getSquareColorsForRow(int rowIndex) {
      List<Color> colors = [];

      for (int i = 0; i < 5; i++) {
        Color squareColor = Colors.grey;

        if (i < _wordleGame.targetWord.length) {
          String targetLetter = _wordleGame.targetWord[i];

          if (i < _guessController.text.length) {
            String guessedLetter = _guessController.text[i];

            if (guessedLetter == targetLetter && i == rowIndex) {
              // Cambiar a verde solo si la letra coincide en posición
              squareColor = Colors.green;
            } else if (_wordleGame.targetWord.contains(guessedLetter) &&
                _wordleGame.targetWord.indexOf(guessedLetter) != i) {
              // Cambiar a amarillo solo si la letra está en la palabra pero no en la posición correcta
              squareColor = Colors.yellow;
            }
          }
        }

        colors.add(squareColor);
      }

      return colors;
    }
  }


class LetterSquare extends StatelessWidget {
  Color colorL;
  String letterL = '';

  LetterSquare(this.colorL, this.letterL);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      color: colorL, // Puedes personalizar el color según tus necesidades
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