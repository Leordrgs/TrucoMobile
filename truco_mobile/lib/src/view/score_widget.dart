import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  final int team1Points;
  final int team2Points;

  ScoreWidget({required this.team1Points, required this.team2Points});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Team 1: $team1Points', style: TextStyle(fontSize: 20)),
        SizedBox(width: 20),
        Text('Team 2: $team2Points', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}