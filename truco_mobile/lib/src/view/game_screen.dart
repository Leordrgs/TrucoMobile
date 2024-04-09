import 'package:flutter/material.dart' hide Table, Card;
import '../model/card_model.dart' as game_model;
import 'card_widget.dart';
import 'score_widget.dart';
import 'action_buttons.dart';
import '../model/table_model.dart' as game_model; // Importe a classe Table aqui

class GameScreen extends StatelessWidget {
  final game_model.Table table;

  /*const GameScreen({Key? key, required this.table}) : super(key: key); // Correção do construtor*/

  const GameScreen(
      {super.key, required this.table}); // Adicione este construtor

  @override
  Widget build(BuildContext context) {
    List<game_model.Card> player1Cards = table.team1.player1.showHand();
    List<game_model.Card> player2Cards = table.team1.player2.showHand();
    List<game_model.Card> player3Cards = table.team2.player1.showHand();
    List<game_model.Card> player4Cards = table.team2.player2.showHand();

    return Scaffold(
      appBar: AppBar(title: const Text('Truco Game')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Widgets que representam as mãos dos jogadores
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Jogador 1
              Column(
                children: [
                  const Text("Player 1"),
                  ...player1Cards
                      .map((card) => SelectableCardWidget(
                            card: card,
                            onTap: () {
                              table.selectedCard = card;
                              table.currentHand = table.team1.player1; // Definindo o jogador atual para teste
                            },
                          ))
                      .toList(),
                ],
              ),
              // Jogador 2
              Column(
                children: [
                  const Text("Player 2"),
                  ...player2Cards
                      .map((card) => CardWidget(card: card))
                      .toList(),
                ],
              ),
              // Jogador 3
              Column(
                children: [
                  const Text("Player 3"),
                  ...player3Cards
                      .map((card) => CardWidget(card: card))
                      .toList(),
                ],
              ),
              // Jogador 4
              Column(
                children: [
                  const Text("Player 4"),
                  ...player4Cards
                      .map((card) => CardWidget(card: card))
                      .toList(),
                ],
              ),
            ],
          ),
          // Texto "Manilha" com a cor e o valor da carta atual
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (table.manilha != null)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Text(
                      "Manilha: ${table.manilha!.rank} de ${table.manilha!.suit}"),
                ),
            ],
          ),
          // Widget que mostra o placar
          ScoreWidget(
            team1Points: table.team1.getPoints(),
            team2Points: table.team2.getPoints(),
          ),
          // Widget com os botões de ação
          ActionButtons(
            onPlayCard: (game_model.Card card) {
              if (table.selectedCard != null) {
                table.playCard(table.currentHand!, table.selectedCard!);
                //table.selectedCard = null;
              }
            },
            onRequestTruco: () {
              table.requestTruco();
            },
            onStartNewRound: (game_model.Table table) {
              table.startNewRound();
            },
            table: table,
          ),
        ],
      ),
    );
  }
}
