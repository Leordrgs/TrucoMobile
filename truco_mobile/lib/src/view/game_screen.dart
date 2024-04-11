import 'package:flutter/material.dart';
import '../model/card_model.dart' as game_model;
import 'card_widget.dart';
import 'score_widget.dart';
import 'action_buttons.dart';
import '../model/table_model.dart' as game_model; // Importe a classe Table aqui

class GameScreen extends StatefulWidget {
  final game_model.Table table;

  GameScreen({Key? key, required this.table}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    List<game_model.Card> player1Cards = widget.table.team1.player1.showHand();
    List<game_model.Card> player2Cards = widget.table.team1.player2.showHand();
    List<game_model.Card> player3Cards = widget.table.team2.player1.showHand();
    List<game_model.Card> player4Cards = widget.table.team2.player2.showHand();

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
                            key: ValueKey(card), // Adicionando a chave
                            onTap: () {
                              setState(() {
                                widget.table.selectedCard = card;
                                widget.table.currentHand = widget.table.team1.player1;
                              });
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
              if (widget.table.manilha != null)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Text(
                      "Manilha: ${widget.table.manilha!.rank} de ${widget.table.manilha!.suit}"),
                ),
            ],
          ),
          // Widget que mostra o placar
          ScoreWidget(
            team1Points: widget.table.team1.getPoints(),
            team2Points: widget.table.team2.getPoints(),
          ),
          // Widget com os botões de ação
          ActionButtons(
            onPlayCard: (game_model.Card card) {
              if (widget.table.selectedCard != null) {
                setState(() {
                  widget.table.playCard(widget.table.currentHand!, widget.table.selectedCard!);
                });
              }
            },
            onRequestTruco: () {
              setState(() {
                widget.table.requestTruco();
              });
            },
            onStartNewRound: (game_model.Table table) {
              setState(() {
                table.startNewRound();
              });
            },
            table: widget.table,
          ),
        ],
      ),
    );
  }
}
