import 'package:flutter/material.dart' hide Table;
import 'package:flutter/material.dart' as flutter;

import '../model/table_model.dart' as game_model;
import '../model/card_model.dart' as game_model;
import '../model/table_model.dart';

class ActionButtons extends StatelessWidget {
  final Function(game_model.Card)
      onPlayCard; // Especificando o tipo da função para onPlayCard
  final Function()
      onRequestTruco; // Especificando o tipo da função para onRequestTruco
  final Function(game_model.Table)
      onStartNewRound; // Especificando o tipo da função para onStartNewRound
  final game_model.Table table;

  const ActionButtons({
    super.key,
    required this.onPlayCard,
    required this.onRequestTruco,
    required this.onStartNewRound,
    required this.table,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            // Selecionar a carta do jogador atual para jogar
            if (table.currentHand != null &&
                table.currentHand!.hand.isNotEmpty) {
              game_model.Card selectedCard = table.currentHand!.hand
                  .first; // Exemplo: seleciona a primeira carta da mão do jogador
              onPlayCard(
                  selectedCard); // Passando a carta selecionada para a classe Table
            }
          },
          child: const Text('Play Card'),
        ),
        ElevatedButton(
          onPressed: () {
            // Alguma lógica para solicitar truco
            // Vamos apenas chamar a função callback por enquanto
            onRequestTruco();
          },
          child: const Text('Request Truco'),
        ),
        ElevatedButton(
          onPressed: () {
            // Alguma lógica para iniciar a partida para teste do emulador
            // Vamos apenas chamar a função callback por enquanto
            onStartNewRound(table);
          },
          child: const Text('Iniciar Partida'),
        ),
      ],
    );
  }
}
