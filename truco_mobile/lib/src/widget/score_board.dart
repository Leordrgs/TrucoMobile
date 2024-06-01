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

  ScoreBoard({
    required this.scoreTeamA,
    required this.scoreTeamB,
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
      padding: EdgeInsets.all(8.0),
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
                children: List.generate(
                  3,
                  (index) => Radio(
                    value: index,
                    groupValue: roundWinner + 1,
                    onChanged: (int? value) {},
                    activeColor: Colors.white,
                  ),
                ),
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
              Row(
                children: List.generate(
                  3,
                  (index) => Radio(
                    value: index,
                    groupValue: roundWinner,
                    onChanged: (int? value) {},
                    activeColor: Colors.white,
                  ),
                ),
              ),
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
