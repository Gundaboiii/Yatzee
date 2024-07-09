import 'package:flutter/material.dart';
import '../models/yahtzeeGame.dart';
import '../views/yahtzee.dart';
import 'package:provider/provider.dart';

enum ScoreCategory {
  ones("Ones"),
  twos("Twos"),
  threes("Threes"),
  fours("Fours"),
  fives("Fives"),
  sixes("Sixes"),
  threeOfAKind("Three of a Kind"),
  fourOfAKind("Four of a Kind"),
  fullHouse("Full House"),
  smallStraight("Small Straight"),
  largeStraight("Large Straight"),
  yahtzee("Yahtzee"),
  chance("Chance");

  const ScoreCategory(this.name);

  final String name;
}

void main() {
  // Used Change Notifier Provider
  runApp(
    ChangeNotifierProvider(
      create: (context) => YahtzeeGame(),
      child: const YahtzeeApp(),
    ),
  );
}

//Main App Widget
class YahtzeeApp extends StatelessWidget {
  const YahtzeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Single Player Yahtzee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const YahtzeeGameScreen(),
    );
  }
}
