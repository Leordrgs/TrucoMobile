import 'package:flutter/material.dart' hide Card;
import '../model/card_model.dart'; // Importe o modelo da carta

class CardWidget extends StatelessWidget {
  final CardModel card;

  CardWidget({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          '${card.rank} de ${card.suit}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}