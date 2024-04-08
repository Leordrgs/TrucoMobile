import 'package:flutter/material.dart' hide Card, Table;
import 'package:flutter/material.dart' hide Table;
import '../model/card_model.dart' as game_model;
import 'card_widget.dart';
import 'score_widget.dart';
import 'action_buttons.dart';
import '../model/table_model.dart';// Importe a classe Table aqui

class GameScreen extends StatelessWidget {
  final Table table; // Adicione esta linha para receber a mesa como parâmetro

  GameScreen({required this.table}); // Adicione este construtor

  @override
  Widget build(BuildContext context) {
    List<game_model.Card> player1Cards = table.team1.player1.showHand();
    List<game_model.Card> player2Cards = table.team1.player2.showHand();
    List<game_model.Card> player3Cards = table.team2.player1.showHand();
    List<game_model.Card> player4Cards = table.team2.player2.showHand();

    return Scaffold(
      appBar: AppBar(title: Text('Truco Game')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Widgets que representam as mãos dos jogadores
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CardWidget(card: player1Cards[0]),
              CardWidget(card: player2Cards[0]),
              CardWidget(card: player3Cards[0]),
              CardWidget(card: player4Cards[0]),
            ],
          ),
          // Widget que mostra o placar
          ScoreWidget(
            team1Points: table.team1.getPoints(),
            team2Points: table.team2.getPoints(),
          ),
          // Widget com os botões de ação
          ActionButtons(
            onPlayCard: (Card card) {
              // Adicione a lógica para jogar a carta aqui
              table.playCard(card as game_model.Card);
            },
            onRequestTruco: () {
              // Adicione a lógica para solicitar truco aqui
              table.requestTruco();
            },
            onStartNewRound: (Table) {
              table.startNewRound();
            },
          ),
        ],
      ),
    );
  }
}
