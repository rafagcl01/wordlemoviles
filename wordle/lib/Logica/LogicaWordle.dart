import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wordle/scenes/Victoria.dart';
import 'package:wordle/scenes/Derrota.dart';


class WordleGame {
  late String _targetWord;
  int _maxAttempts = 6;
  List<String> FoodWords =  ['FIDEO', 'MELON', 'DONUT', 'FRESA', 'TACOS', 'PASTA', 'CARNE', 'FRUTA', 'ARROZ', 'PIZZA'];
  List<String> AnimalWords = ['FAUNA', 'GARRA', 'PLUMA', 'RATON', 'CAZAR', 'CRIAR', 'HUIDA', 'CEBRA', 'RUGIR', 'ALADO'];
  List<String> OceanWords = ['PULPO', 'REDES', 'PESCA', 'NADAR', 'CORAL', 'COSTA', 'BUZOS', 'OSTRA', 'ALGAS', 'BAHIA'];
   late int gameSelectedList;
  List<String> wordList = [];
  List<String> _previousGuesses = [];
  bool _isGameOver = false;
  int _currentAttempt = 0; // Nuevo miembro para el intento actual



  WordleGame({required int list , int maxAttempts = 6} ) {
    gameSelectedList = list;
    _targetWord = _generateRandomWord();
    _maxAttempts = maxAttempts;
  }

  String get targetWord => _targetWord;
  int get maxAttempts => _maxAttempts;
  int get currentAttempt => _currentAttempt; // Nuevo getter para el intento actual
  List<String> get previousGuesses => List.from(_previousGuesses);
  bool get isGameOver => _isGameOver;

  void setSelectedList(int value){
    gameSelectedList = value;
  }


  String _generateRandomWord() {
    int min = 0;
    Random random = Random();
    if(gameSelectedList == 0){
      wordList = FoodWords;
    } else if (gameSelectedList == 1){
      wordList = AnimalWords;
    } else if (gameSelectedList == 2){
      wordList = OceanWords;
    }
    return wordList[random.nextInt((wordList.length))];
  }

  String submitGuess(BuildContext context, String guess) {
    if (_isGameOver) {
      // Navegar a la escena de derrota
      Navigator.pushNamed(
        context,
        '/defeat',
        arguments: {'word': _targetWord}
      );
    }

    _previousGuesses.add(guess);
    _currentAttempt++; // Incrementar el intento actual

    if (guess == _targetWord) {
      _isGameOver = true;
      // Navegar a la escena de victoria
      Navigator.pushNamed(
        context,
        '/victory',
        arguments: {'word': _targetWord}
      );
    }

    if (_previousGuesses.length == _maxAttempts-1) {
      _isGameOver = true;
      return '¡Oh no! Has agotado tus intentos. La palabra era: $_targetWord';
    }

    return _generateHint(guess);
  }

  String _generateHint(String guess) {
    List<String> targetChars = _targetWord.split('');
    List<String> guessChars = guess.split('');

    int correctPositionCount = 0;
    int correctCharacterCount = 0;

    for (int i = 0; i < targetChars.length; i++) {
      if (targetChars[i] == guessChars[i]) {
        correctPositionCount++;
      } else if (targetChars.contains(guessChars[i])) {
        correctCharacterCount++;
      }
    }

    return 'Pistas: $correctPositionCount en posición correcta, $correctCharacterCount letra(s) correcta(s) pero en posición incorrecta.';
  }
}