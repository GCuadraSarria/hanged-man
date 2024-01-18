import 'package:ahorcado/components/components.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:normalizer/normalizer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // whole alphabet
  List<String> alphabet = [
    'Q',
    'W',
    'E',
    'R',
    'T',
    'Y',
    'U',
    'I',
    'O',
    'P',
    'A',
    'S',
    'D',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
    'Ñ',
    'Z',
    'X',
    'C',
    'V',
    'B',
    'N',
    'M',
    'New Game'
  ];

  // guesses
  int guesses = 0;

  // player lost
  bool playerLost = false;

  // player won
  bool playerWon = false;

  // player won or lost
  bool gameFinished = false;

  // answer word
  String answerWord = 'DEFAULT';

  // selected letters
  List<String> selectedLetters = [];

  // correct selected letters
  List<String> correctSelectedLetters = [];

  // clean HTTP word (capitals and accents)
  void cleanHttpWord(String response) {
    setState(() {
      answerWord = response.normalize().toUpperCase();
    });
  }

  // check if player lost the game
  void checkPlayerLost() {
    // we fill the correctSelectedLetters so it's display
    // and we see the correct final answer
    setState(() {
      correctSelectedLetters.clear();
      playerLost = true;
      gameFinished = true;
      for (int i = 0; i < answerWord.length; i++) {
        correctSelectedLetters.add(answerWord[i]);
      }
    });
  }

  // check if player won the game
  void checkPlayerWon() {
    // loop thru the answer word
    for (int i = 0; i < answerWord.length; i++) {
      // if a letter is not in the correct list, we didn't win yet
      if (!correctSelectedLetters.contains(answerWord[i])) {
        return;
      }
    }
    playerWon = true;
    gameFinished = true;
  }

  // guess a letter
  void guessLetter(String value) {
    setState(() {
      selectedLetters.add(value);
      // if the selected letter is in the answerWord
      // we add it to the correct list
      if (answerWord.contains(value)) {
        correctSelectedLetters.add(value);
        checkPlayerWon();
      } else {
        guesses++;
        if (guesses == 6) checkPlayerLost();
      }
    });
  }

  // start new game
  void newGame() {
    setState(() {
      playerLost = false;
      playerWon = false;
      gameFinished = false;
      selectedLetters.clear();
      correctSelectedLetters.clear();
      guesses = 0;
      getRandomWord();
    });
  }

  // call API
  @override
  void initState() {
    super.initState();
    getRandomWord();
  }

  // get word method
  //https://clientes.api.greenborn.com.ar/public-random-word
  Future<void> getRandomWord() async {
    final response = await Dio()
        .get('https://clientes.api.greenborn.com.ar/public-random-word');
    // if the word characters are not between 5 and 9 we get another word from the API
    response.data[0].length >= 5 && response.data[0].length < 10
        ? cleanHttpWord(response.data[0])
        : getRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    // screen size
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54, width: 1.25),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // top hearts and win / lose msg
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HeartRow(guesses: guesses),
                              playerLost
                                  ? const Text(
                                      'Y O U  D I E D',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                      ),
                                    )
                                  : playerWon
                                      ? const Text(
                                          'Y O U  S U R V I V E D',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.0,
                                          ),
                                        )
                                      : const Text(''),
                            ],
                          ),
                        ),
                      ),
                      // hangman images
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Image.asset('lib/assets/HM-0${6 - guesses}.png', color: Colors.white54),
                        ),
                      ),
                      // guess word display
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: answerWord.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: answerWord.length),
                              itemBuilder: (BuildContext context, int index) {
                                if (correctSelectedLetters
                                    .contains(answerWord[index])) {
                                  return GuessSpace(
                                    width: screenSize.width / answerWord.length,
                                    letter: answerWord[index],
                                  );
                                } else {
                                  return GuessSpace(
                                    width: screenSize.width / answerWord.length,
                                    letter: '',
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // keyboard display
            Wrap(
              children: alphabet
                  .map((value) => SizedBox(
                        width: value == 'New Game'
                            // new game button three times bigger than the rest
                            ? screenSize.width / (10 / 3)
                            : screenSize.width / 10,
                        height: screenSize.width / 7,
                        child: value == 'New Game'
                            // new game button
                            ? NewGameKey(
                                value: value,
                                ontap: () => newGame(),
                                gameFinished: gameFinished)
                            : correctSelectedLetters.contains(value)
                                ?
                                // correct letters
                                SelectedLetterKey(
                                    value: value,
                                    correct: !gameFinished,
                                  )
                                // non correct letters
                                : selectedLetters.contains(value)
                                    ? SelectedLetterKey(
                                        value: value, correct: false)
                                    :
                                    // non selected letters
                                    LetterKey(
                                        gameFinished: gameFinished,
                                        value: value,
                                        ontap: () => !gameFinished
                                            ? guessLetter(value)
                                            : null),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
