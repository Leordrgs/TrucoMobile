import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showRoundWinnerToast(
    int roundNumber, Map<String, dynamic> highestRankCard) {
  Fluttertoast.showToast(
    msg:
        "O vencedor da rodada ${roundNumber + 1} foi ${highestRankCard['player'].name}",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showHandWinnerToast(
    int roundNumber, Map<String, dynamic> highestRankCard) {
  Fluttertoast.showToast(
      msg:
          "O vencedor da mão foi ${highestRankCard['player'].name} e foi adicionado um ponto ao placar!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.blue,
      textColor: Colors.black,
      fontSize: 16.0);
}

void showTiedRoundToast(int roundNumber) {
  Fluttertoast.showToast(
      msg: "Empate na rodada ${roundNumber + 1}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
