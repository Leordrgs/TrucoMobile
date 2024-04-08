import 'package:flutter/material.dart' hide Card;

class ScoreWidget extends StatelessWidget {
  final int team1Points;
  final int team2Points;  

  const ScoreWidget({super.key, required this.team1Points, required this.team2Points});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Team 1: $team1Points', style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 20),
        Text('Team 2: $team2Points', style: const TextStyle(fontSize: 20)),        
      ],
    );
  }
}