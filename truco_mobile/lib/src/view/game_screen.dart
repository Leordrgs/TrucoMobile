import 'package:flutter/material.dart' hide Table;
import '../model/card_model.dart' as game_model;
import 'card_widget.dart';
import 'score_widget.dart';
import 'action_buttons.dart';
import '../model/table_model.dart'; // Importe a classe Table aqui

class GameScreen extends StatelessWidget {
  final Table table; // Adicione esta linha para receber a mesa como parâmetro

  const GameScreen(
      {super.key, required this.table}); // Adicione este construtor

  @override
  Widget build(BuildContext context) {
    List<game_model.Card> player1Cards = table.teams[0].players[0].showHand();
    List<game_model.Card> player2Cards = table.teams[0].players[1].showHand();
    List<game_model.Card> player3Cards = table.teams[1].players[0].showHand();
    List<game_model.Card> player4Cards = table.teams[1].players[1].showHand();

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
                  const Text("Player 1"), // Nome do jogador
                  ...player1Cards.map((card) => CardWidget(card: card)).toList(),
                ],
              ),
              // Jogador 2
              Column(
                children: [
                  const Text("Player 2"), // Nome do jogador
                  ...player2Cards.map((card) => CardWidget(card: card)).toList(),
                ],
              ),
              // Jogador 3
              Column(
                children: [
                  const Text("Player 3"), // Nome do jogador
                  ...player3Cards.map((card) => CardWidget(card: card)).toList(),
                ],
              ),
              // Jogador 4
              Column(
                children: [
                  const Text("Player 4"), // Nome do jogador
                  ...player4Cards.map((card) => CardWidget(card: card)).toList(),
                ],
              ),
            ],
          ),
          // Texto "Manilha" com a cor e o valor da carta atual
          Row(            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (table.manilha != null)
                //const SizedBox(width: 20), //Espaçamento
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 100),                
                  child: Text("Manilha: ${table.manilha!.rank} de ${table.manilha!.suit}"),                          
                ),
            ],            
          ),
          // Widget que mostra o placar
          ScoreWidget(
            team1Points: table.teams[0].getPoints(),
            team2Points: table.teams[1].getPoints(),
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
