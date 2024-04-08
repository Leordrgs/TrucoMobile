import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final void Function(Card)
      onPlayCard; // Especificando o tipo da função para onPlayCard
  final void Function()
      onRequestTruco; // Especificando o tipo da função para onRequestTruco
  final void Function(Table)
      onStartNewRound; // Especificando o tipo da função para onStartNewRound
  

  const ActionButtons({super.key, 
    required this.onPlayCard,
    required this.onRequestTruco,
    required this.onStartNewRound,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            // Alguma lógica para jogar a carta
            // Vamos apenas chamar a função callback por enquanto
            onPlayCard(const Card()); // Passando uma carta fictícia como exemplo
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
            onStartNewRound(Table());            
          },
          child: const Text('Iniciar Partida'),
        ),
      ],
    );
  }
}
