import 'package:flutter/material.dart';
import 'package:wordle/Logica/LogicaWordle.dart';

class Wordle extends StatefulWidget {
  @override
  _WordleState createState() => _WordleState();
}

class _WordleState extends State<Wordle> {
  late WordleGame _wordleGame;
  late int selectedList;

  String _currentInput = '';
  int contEnteredLetter = 0;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    selectedList = arguments['lista'] ?? 0;
    //_wordleGame.setSelectedList(selectedList);
    _wordleGame = WordleGame(list: selectedList);
  }


  List<LetterSquare> _enteredLetters = List.generate(
    5, (index) => LetterSquare(Colors.greenAccent, ''),
  );

  List<List<LetterSquare>> letterSquareGrid = List.generate(
    6, (row) =>
      List.generate(
        5, (col) => LetterSquare(Colors.grey, ''),
      ),
  );



  Widget buildEnteredLettersRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _enteredLetters.map((letterSquare) {
        return Container(
          width: 35,
          height: 35,
          color: letterSquare.colorL,
          margin: EdgeInsets.all(5),
          child: Center(
            child: Text(
              letterSquare.letterL,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wordle Game - Juego'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildEnteredLettersRow(),
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
              Text('Intentos restantes: ${_wordleGame.maxAttempts -
                _wordleGame.previousGuesses.length}'),
            ],
          ),
        ),
      ),
    );

  }



  Widget buildKeyboard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildRow(['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P']),
        buildRow(['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L']),
        buildRow(['Z', 'X', 'C', 'V', 'B', 'N', 'M']),
        buildRow(['Delete', ' ', 'Submit']),
      ],
    );
  }

  Widget buildRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((key){
        return buildKeyButton(key);
      }).toList(),
    );
  }

  Widget buildKeyButton(String key) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(0.0),
        child :ElevatedButton(
          onPressed: () {
            handleKey(key);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
          ),
          child: Center( // Center the text within the button
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Text(key),
          ),
        ),
      )
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
        contEnteredLetter --;
        _updateEnteredLetters(contEnteredLetter, Colors.greenAccent, "");
      } else if (key == 'Submit' && _currentInput.length == 5) {
        _wordleGame.submitGuess(context, _currentInput);
        _updateSquares();
        contEnteredLetter = 0;
        for (int i = 0; i < 5; i++) {
          _updateEnteredLetters(i, Colors.greenAccent, "");
        }
        _currentInput = '';
      } else
      if (key != 'Delete' && key != 'Submit' && _currentInput.length < 5) {
        _currentInput += key;
        _updateEnteredLetters(contEnteredLetter, Colors.greenAccent, key);
        contEnteredLetter ++;
        //_updateSquares();
      }
    });
  }

  void _updateEnteredLetters(int i, Color newColor, String key) {
    setState(() {
      _enteredLetters[i] = LetterSquare(newColor, key);
    });
  }

  void _updateSquares() {
    int currentAttemptIndex = _wordleGame.currentAttempt - 1;

    // USAMOS UN MAP letterCount PARA SABER CUANTAS HAY DE CADA LETRA DE LA PALABRA TARGET
    // USAMOS UN MAP correctLetters PARA SABER QUÉ LETRAS HEMOS HACERTADO
    // LUEGO LAS COMPARAMOS PARA MANEJAR LOS CUADRADOS AMARILLOS

    // Utilizamos un Map para llevar un recuento de las letras
    Map<String, int?> letterCount = {};
    // Iteramos sobre cada letra en la palabra
    for (int i = 0; i < _wordleGame.targetWord.length; i++) {
      String letter = _wordleGame.targetWord[i];
      // Verificamos si la letra ya está en el Map
      if (letterCount.containsKey(letter)) {
        // Si la letra ya está, incrementamos su contador
        if (letterCount[letter] != null) {
          letterCount[letter] = letterCount[letter]! + 1; //aseguramos que el valor no sea nulo
        } else {
          letterCount[letter] = 1;
        }
      } else {
        // Si la letra no está, la añadimos al Map con un contador de 1
        letterCount[letter] = 1;
      }
    }

    // Utilizamos un Map para llevar un recuento de las letras que acertamos
    Map<String, int?> correctLetters = {};
    List<int> correctPositions = [];
    Map<String, int?> wrongButExists = {};


    for (int i = 0; i < 5; i++) { //este primer for comprueba las letras acertadas, las pone verdes y las añade a un mapa
      if (i < _wordleGame.targetWord.length) {
        String targetLetter = _wordleGame.targetWord[i];

        if (i < _currentInput.length) {
          String guessedLetter = _currentInput[i];

          //si acertamos la letra
          if (guessedLetter == targetLetter) {
            if (correctLetters.containsKey(guessedLetter)) { //añadimos esa letra a la lista de acertadas
              if (correctLetters[guessedLetter] != null) {
                correctLetters[guessedLetter] = correctLetters[guessedLetter]! + 1; //aseguramos que el valor no sea nulo
              } else {
                correctLetters[guessedLetter] = 1;
              }
            } else {
              correctLetters[guessedLetter] = 1;
            }
            //y ponemos el cuadro como verde
            updateSquareColor(currentAttemptIndex, i, Colors.green);
            correctPositions.add(i);
          }
        }
      }
    }
    
      for (int i = 0; i < 5; i++) { //este segundo for comprueba las letras en pos incorrectas y las erroneas ya sabiendo cuales hemos acertado

        if(!correctPositions.contains(i)){  //ahora solo miramos las posiciones que no hayan sido acertadas antes

          if (i < _wordleGame.targetWord.length) {
            String targetLetter = _wordleGame.targetWord[i];

            if (i < _currentInput.length) {
              String guessedLetter = _currentInput[i];

              //si no acertamos la letra pero existe en la palabra
              if (_wordleGame.targetWord.contains(guessedLetter) &&
                  _wordleGame.targetWord.indexOf(guessedLetter) != i) {
                //comprobamos que aun existiendo, no la hayamos acertado ya
                if (correctLetters[guessedLetter] == null || correctLetters[guessedLetter]! < letterCount[guessedLetter]!) {

                  //comprobamos que aun existiendo, no la hayamos puesto ya como amarilla, para que no parezca que hay 4 "a" en posiciones incorrectas cuando solo hay 1
                  if(wrongButExists[guessedLetter] == null || wrongButExists[guessedLetter]! < letterCount[guessedLetter]!) {
                    updateSquareColor(currentAttemptIndex, i, Colors.yellow);
                    //la añadimos a la lista de wrongbutexists
                    if (wrongButExists[guessedLetter] != null) {
                      wrongButExists[guessedLetter] =
                          wrongButExists[guessedLetter]! +
                              1; //aseguramos que el valor no sea nulo
                    } else {
                      wrongButExists[guessedLetter] = 1;
                    }
                  }else{
                  updateSquareColor(currentAttemptIndex, i, Colors.grey[600]!);
                }

                }else{
                  updateSquareColor(currentAttemptIndex, i, Colors.grey[600]!);
                }

              // si no acertamos la letra y no existe
              } else {
                updateSquareColor(currentAttemptIndex, i, Colors.grey[600]!);
                //letterSquareGrid[currentAttemptIndex][i].updateColor(Colors.grey);
              }
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

