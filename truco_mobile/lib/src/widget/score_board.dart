import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final int scoreTeamA;
  final int scoreTeamB;
  final Color color;
  final double size;
  final Color fontColor;
  int roundWinner = 0;
  final String playerA;
  final String playerB;
  final bool roundOneWinnerA;
  final bool roundOneWinnerB;
  final bool roundTwoWinnerA;
  final bool roundTwoWinnerB;
  final bool roundThreeWinnerA;
  final bool roundThreeWinnerB;

  ScoreBoard({
    super.key, 
    required this.scoreTeamA,
    required this.scoreTeamB,
    required this.roundOneWinnerA,
    required this.roundOneWinnerB,
    required this.roundTwoWinnerA,
    required this.roundTwoWinnerB,
    required this.roundThreeWinnerA,
    required this.roundThreeWinnerB,
    required this.playerA,
    required this.playerB,
    this.color = Colors.white,
    this.size = 14.0,
    this.fontColor = Colors.black,
    this.roundWinner = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                playerA,
                style: TextStyle(
                    fontSize: size,
                    fontWeight: FontWeight.bold,
                    color: fontColor),
              ),
              Row(
                children: [
                  Checkbox(
                    value: roundOneWinnerA,
                    activeColor: Colors.white,
                    onChanged: (bool? value) {},
                  ),
                  Checkbox(
                    value: roundTwoWinnerA,
                    activeColor: Colors.white,
                    onChanged: (bool? value) {},
                  ),
                  Checkbox(
                    value: roundThreeWinnerA,
                    activeColor: Colors.white,
                    onChanged: (bool? value) {},
                  )
                ],
              ),
              Text(
                '$scoreTeamA',
                style: TextStyle(fontSize: size, color: fontColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                playerB,
                style: TextStyle(
                    fontSize: size,
                    fontWeight: FontWeight.bold,
                    color: fontColor),
              ),
              Row(children: [
                Checkbox(
                  value: roundOneWinnerB,
                  activeColor: Colors.white,
                  onChanged: (bool? value) {},
                ),
                Checkbox(
                  value: roundTwoWinnerB,
                  activeColor: Colors.white,
                  onChanged: (bool? value) {},
                ),
                Checkbox(
                  value: roundThreeWinnerB,
                  activeColor: Colors.white,
                  onChanged: (bool? value) {},
                ),
              ]),
              Text(
                '$scoreTeamB',
                style: TextStyle(fontSize: size, color: fontColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
