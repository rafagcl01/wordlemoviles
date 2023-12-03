import 'dart:math';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wordle/scenes/Victoria.dart';
import 'package:wordle/scenes/Derrota.dart';
//import 'package:wordle/Logica/Words.json';

class WordleGame {
  late String _targetWord;
  int _maxAttempts = 6;
  List<String> wordList = ["beban"/*, "avion", "flaco", "envia", "ostra", "rubio", "lacio", "carta", "rotas"*/];
  List<String> _previousGuesses = [];
  bool _isGameOver = false;

  WordleGame({int maxAttempts = 6}) {

    _targetWord = _generateRandomWord();
    _maxAttempts = maxAttempts;
  }

  String get targetWord => _targetWord;
  int get maxAttempts => _maxAttempts;
  List<String> get previousGuesses => List.from(_previousGuesses);
  bool get isGameOver => _isGameOver;

  //movidas del json que no logré que funcionaran
  /*
 void loadWordsFromJson()  {
    //try{
      File file = File('Words.json');
      String content =  file.readAsStringSync();

      Map<String, dynamic> jsonData = jsonDecode(content);

      List<dynamic> palabrasJson = jsonData['lista'];

      wordList = palabrasJson.map((palabra) => palabra.toString()).toList();
      print(wordList);
    /*} catch (e) {
      print('Error al cargar la lista de palabras del json');
    }*/
  }

  Future<void> callToLoad() async{
    //await loadWordsFromJson();
  }

  void ensureList() async{
    if (wordList.isEmpty) {
       loadWordsFromJson();
    }
  }
   */

  String _generateRandomWord() {
   
    int min = 0;
    Random random = Random();
    return wordList[random.nextInt((wordList.length))];

  }

  String submitGuess(BuildContext context, String guess) {

    if (_isGameOver) {
      // Navegar a la escena de victoria
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Derrota()),
      );
    }

    _previousGuesses.add(guess);

    if (guess == _targetWord) {
      _isGameOver = true;
      // Navegar a la escena de victoria
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Victoria()),
      );

    }

    if (_previousGuesses.length >= _maxAttempts) {
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