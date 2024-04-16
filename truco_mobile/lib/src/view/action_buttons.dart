import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final void Function(Card) onPlayCard;
  final void Function() onRequestTruco;
  final void Function(Table) onStartNewRound;

  const ActionButtons({
    super.key,
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
            onPlayCard(const Card());
          },
          child: const Text('Play Card'),
        ),
        ElevatedButton(
          onPressed: () {
            onRequestTruco();
          },
          child: const Text('Request Truco'),
        ),
        ElevatedButton(
          onPressed: () {
            onStartNewRound(Table());
          },
          child: const Text('Iniciar Partida'),
        ),
      ],
    );
  }
}
