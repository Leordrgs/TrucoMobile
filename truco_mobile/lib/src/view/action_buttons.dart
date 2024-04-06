import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final void Function(Card) onPlayCard;  // Especificando o tipo da função para onPlayCard
  final void Function() onRequestTruco;   // Especificando o tipo da função para onRequestTruco

  ActionButtons({
    required this.onPlayCard,
    required this.onRequestTruco,
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
            onPlayCard(Card());  // Passando uma carta fictícia como exemplo
          },
          child: Text('Play Card'),
        ),
        ElevatedButton(
          onPressed: () {
            // Alguma lógica para solicitar truco
            // Vamos apenas chamar a função callback por enquanto
            onRequestTruco();
          },
          child: Text('Request Truco'),
        ),
      ],
    );
  }
}
