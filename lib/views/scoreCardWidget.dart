import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/yahtzeeGame.dart';

class ScoreCardWidget extends StatelessWidget {
  const ScoreCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<YahtzeeGame>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Center(
            child: Text(
              'Score Card',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Table layout for categories and scores
          Table(
            border: TableBorder.all(color: Colors.grey),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
            },
            children: [
              // Table header
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      'Score',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              // Table rows for each category
              for (final category in ScoreCategory.values)
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!game.isCategoryUsed(category)) {
                          game.registerScore(
                              category, game.categoryScores[category.name]);
                        }
                        if (game.chanceLeft == 0) {
                          game.showGameOverDialog(context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          game.isCategoryUsed(category)
                              ? game.usedCategoryScores[category.name]
                                  .toString()
                              : game.categoryScores[category.name].toString(),
                          style: game.isCategoryUsed(category)
                              ? const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                )
                              : const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
