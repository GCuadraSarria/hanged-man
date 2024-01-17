import 'package:ahorcado/components/components.dart';
import 'package:flutter/material.dart';

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

  // answer word
  String answerWord = 'HANGUEDAS';

  // selected letters
  List<String> selectedLetters = [];

  // correct selected letters
  List<String> correctSelectedLetters = [];

  // check if player lost the game
  void checkPlayerLost() {
    print('Player lost');
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
    print('Player won');
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
        if (guesses == 5) checkPlayerLost();
      }
    });
  }

  // start new game
  void newGame() {
    setState(() {
      selectedLetters.clear();
      correctSelectedLetters.clear();
      guesses = 0;
    });
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
                      Expanded(
                        child: Center(
                          child: Text(
                            'Times guessed: $guesses',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18.0),
                          ),
                        ),
                      ),
                      // guess word display
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: GridView.builder(
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
                        height: screenSize.width / 8,
                        child: value == 'New Game'
                            // new game button
                            ? NewGameKey(value: value, ontap: () => newGame())
                            : correctSelectedLetters.contains(value)
                                ?
                                // correct letters
                                SelectedLetterKey(value: value, correct: true)
                                // non correct letters
                                : selectedLetters.contains(value)
                                    ? SelectedLetterKey(
                                        value: value, correct: false)
                                    :
                                    // non selected letters
                                    LetterKey(
                                        value: value,
                                        ontap: () => guessLetter(value)),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
