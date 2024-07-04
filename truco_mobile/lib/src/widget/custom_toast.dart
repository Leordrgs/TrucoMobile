import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showRoundWinnerToast(
    int roundNumber, Map<String, dynamic> highestRankCard) {
  Fluttertoast.showToast(
    msg:
        "O vencedor da rodada ${roundNumber + 1} foi ${highestRankCard['player'].name}",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
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
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.black,
      fontSize: 16.0);
}

void showTiedRoundToast(int roundNumber) {
  Fluttertoast.showToast(
      msg: "Empate na rodada ${roundNumber + 1}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showGameWinnerToast(String playerName) {
  Fluttertoast.showToast(
      msg: "O vencedor do jogo foi ${playerName}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.yellow,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showIsNotYourTurn(String playerName) {
  Fluttertoast.showToast(
      msg: 'Não é o seu turno!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
    );
}

void genericToast(String message, Color backgroundColor, Color textColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0);
}