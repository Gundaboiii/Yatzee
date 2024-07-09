import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import '../main.dart';

// Include all game logic and its functions
class YahtzeeGame extends ChangeNotifier {
  List<int> diceValues = [1, 2, 3, 4, 5];
  int rollsLeft = 3;
  int chanceLeft = 13;
  int totalScore = 0;
  Set<String> usedCategories = {};
  List<bool> reservedDice = [false, false, false, false, false];

  Map<String, int> usedCategoryScores = {
    'Ones': 0,
    'Twos': 0,
    'Threes': 0,
    'Fours': 0,
    'Fives': 0,
    'Sixes': 0,
    'Three of a Kind': 0,
    'Four of a Kind': 0,
    'Full House': 0,
    'Small Straight': 0,
    'Large Straight': 0,
    'Yahtzee': 0,
    'Chance': 0,
  };
  // Initialize categoryScores with 0 for all categories
  Map<String, int> categoryScores = {
    'Ones': 0,
    'Twos': 0,
    'Threes': 0,
    'Fours': 0,
    'Fives': 0,
    'Sixes': 0,
    'Three of a Kind': 0,
    'Four of a Kind': 0,
    'Full House': 0,
    'Small Straight': 0,
    'Large Straight': 0,
    'Yahtzee': 0,
    'Chance': 0,
  };

// Rolls the unreserved Dice
  void rollDice() {
    if (rollsLeft > 0) {
      for (int i = 0; i < 5; i++) {
        if (!reservedDice[i]) {
          diceValues[i] = Random().nextInt(6) + 1;
        }
      }
      rollsLeft--;
      calculateScores();
      notifyListeners();
    }
  }

//RESET ROLLLEFT, DICE to 1 2 3 4 5 and reduce chance by 1
  void resetDice() {
    diceValues = [1, 2, 3, 4, 5];
    reservedDice = [false, false, false, false, false];
    rollsLeft = 3;
    chanceLeft--;
    notifyListeners();
  }

//To reset scoreboard at the end of the game
  void resetScoreboard() {
    chanceLeft = 13;
    totalScore = 0;
    usedCategories = {};
    usedCategoryScores.forEach((key, value) {
      usedCategoryScores[key] = 0;
    });
    categoryScores.forEach((key, value) {
      categoryScores[key] = 0;
    });
    notifyListeners();
  }

// Calculate the scores for each category based on the current dice values.
  void calculateScores() {
    final uniqueVals = Set.from(diceValues);
    for (var category in ScoreCategory.values) {
      if (category == ScoreCategory.yahtzee) {
        if (isYahtzee()) {
          categoryScores[category.name] = 50;
        }
      } else if (category == ScoreCategory.chance) {
        categoryScores[category.name] = diceValues.reduce((a, b) => a + b);
      } else if (category == ScoreCategory.threeOfAKind) {
        if (diceValues
            .any((d) => diceValues.where((d2) => d2 == d).length >= 3)) {
          categoryScores[category.name] = diceValues.sum;
        } else {
          categoryScores[category.name] = 0;
        }
      } else if (category == ScoreCategory.fourOfAKind) {
        if (diceValues
            .any((d) => diceValues.where((d2) => d2 == d).length >= 4)) {
          categoryScores[category.name] = diceValues.sum;
        } else {
          categoryScores[category.name] = 0;
        }
      } else if (category == ScoreCategory.fullHouse) {
        if (uniqueVals.length == 2 &&
            uniqueVals
                .any((d) => diceValues.where((d2) => d2 == d).length == 3)) {
          categoryScores[category.name] = 25;
        } else {
          categoryScores[category.name] = 0;
        }
      } else if (category == ScoreCategory.smallStraight) {
        if (uniqueVals.containsAll([1, 2, 3, 4]) ||
            uniqueVals.containsAll([2, 3, 4, 5]) ||
            uniqueVals.containsAll([3, 4, 5, 6])) {
          categoryScores[category.name] = 30;
        } else {
          categoryScores[category.name] = 0;
        }
      } else if (category == ScoreCategory.largeStraight) {
        if (uniqueVals.containsAll([1, 2, 3, 4, 5]) ||
            uniqueVals.containsAll([2, 3, 4, 5, 6])) {
          categoryScores[category.name] = 40;
        } else {
          categoryScores[category.name] = 0;
        }
      } else {
        int valueToMatch = category == ScoreCategory.threeOfAKind ||
                category == ScoreCategory.fourOfAKind
            ? 3
            : 0;
        int count = diceValues.where((die) => die == category.index + 1).length;
        if (count >= valueToMatch) {
          categoryScores[category.name] = count * (category.index + 1);
        }
      }
    }
    notifyListeners();
  }

// Check if all dice values are the same (Yahtzee)
  bool isYahtzee() {
    return diceValues.toSet().length == 1;
  }

  void calculateTotalScore() {
    totalScore = usedCategoryScores.values.reduce((a, b) => a + b);
    notifyListeners();
  }

// Registers the score of specific category
  void registerScore(ScoreCategory category, score) {
    if (!usedCategories.contains(category.name)) {
      usedCategories.add(category.name);
      usedCategoryScores[category.name] = score;

      // Start a new turn
      calculateTotalScore();
      resetDice();
      notifyListeners();
    }
  }

  void toggleReserved(int index) {
    reservedDice[index] = !reservedDice[index];
    notifyListeners();
  }

  bool isCategoryUsed(ScoreCategory category) {
    return usedCategories.contains(category.name.toString());
  }

  void showGameOverDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text(
              'You have used all your chances! Your final score is $totalScore'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                resetDice();
                resetScoreboard();
                Navigator.of(context).pop();
              },
              child: const Text('Restart Game'),
            ),
          ],
        );
      },
    );
  }
}
