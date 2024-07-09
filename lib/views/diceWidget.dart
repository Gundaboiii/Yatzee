import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/yahtzeeGame.dart';

class DiceWidget extends StatelessWidget {
  final int index;
  final bool isReserved;
  final Function() onToggleReserved;

  const DiceWidget({
    super.key,
    required this.index,
    required this.isReserved,
    required this.onToggleReserved,
  });

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<YahtzeeGame>(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: isReserved ? Colors.orangeAccent : Colors.orange,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            '${game.diceValues[index]}',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: onToggleReserved,
          child: Text(isReserved ? 'UnHold' : 'Hold'),
        ),
      ],
    );
  }
}
