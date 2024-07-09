import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/yahtzeeGame.dart';
import '../views/scoreCardWidget.dart';
import '../views/diceWidget.dart';

class YahtzeeGameScreen extends StatelessWidget {
  const YahtzeeGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<YahtzeeGame>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        toolbarHeight: 40,
        title: const Text(
          'Yahtzee',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            // INFO SECTION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Rolls Left: ${game.rollsLeft}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Chances Left: ${game.chanceLeft}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // DICE ROW WIDGET
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < 5; i++)
                  DiceWidget(
                    index: i,
                    isReserved: game.reservedDice[i],
                    onToggleReserved: () {
                      game.toggleReserved(i);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
            // SCORECARD WIDGET
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 214, 210, 210),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: ScoreCardWidget()),
                    const SizedBox(height: 10),
                    // TOTAL SCORE WIDGET
                    Text(
                      'Total Score: ${game.totalScore}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    // ROLL DICE BUTTON
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: game.rollsLeft > 0
                          ? () {
                              game.rollDice();
                            }
                          : null,
                      child: Text(
                        game.rollsLeft > 0 ? 'Roll Dice' : 'Select Score',
                        style: const TextStyle(fontSize: 16),
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
