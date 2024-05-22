import 'package:flutter/material.dart';
import 'package:flutter_hangman/components/action_button.dart';
import 'package:flutter_hangman/utilities/hangman_words.dart';

class HomeScreen extends StatefulWidget {
  final HangmanWords hangmanWords = HangmanWords();

  HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    widget.hangmanWords.readWords();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 8.0),
                child: const Text(
                  'HANGMAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 58.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 3.0,
                  ),
                ),
              ),
            ),
            Center(
              child: Image.asset(
                'images/gallow.png',
                height: height * 0.49,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Center(
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 64,
                      child: ActionButton(
                        buttonTitle: 'Start',
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    SizedBox(
                      height: 64,
                      child: ActionButton(
                        buttonTitle: 'High Score',
                        onPress: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}