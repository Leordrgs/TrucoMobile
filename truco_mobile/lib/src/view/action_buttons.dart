import 'package:flutter/material.dart';
import '../model/table_model.dart' as game_model;
import '../model/card_model.dart' as game_model;

class ActionButtons extends StatefulWidget {
  final Function(game_model.Card) onPlayCard;
  final Function() onRequestTruco;
  final Function(game_model.Table) onStartNewRound;
  final game_model.Table table;

  const ActionButtons({
    Key? key,
    required this.onPlayCard,
    required this.onRequestTruco,
    required this.onStartNewRound,
    required this.table,
  }) : super(key: key);

  @override
  _ActionButtonsState createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            if (widget.table.currentHand != null &&
                widget.table.currentHand!.hand.isNotEmpty) {
              game_model.Card selectedCard =
                  widget.table.currentHand!.hand.first;
              widget.onPlayCard(selectedCard);
            }
          },
          child: const Text('Play Card'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onRequestTruco();
          },
          child: const Text('Request Truco'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onStartNewRound(widget.table);
          },
          child: const Text('Iniciar Partida'),
        ),
      ],
    );
  }
}
