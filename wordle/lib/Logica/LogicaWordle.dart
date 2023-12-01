import 'dart:math';

class WordleGame {
  late String _targetWord;
  int _maxAttempts = 6;
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

  String _generateRandomWord() {
    List<String> wordList = ['apple', 'banana', 'orange', 'grape', 'lemon'];
    Random random = Random();
    return wordList[random.nextInt(wordList.length)];
  }

  String submitGuess(String guess) {
    if (_isGameOver) {
      return 'El juego ha terminado. Reinicia para jugar de nuevo.';
    }

    _previousGuesses.add(guess);

    if (guess == _targetWord) {
      _isGameOver = true;
      return '¡Felicidades! Has adivinado la palabra.';
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