import 'package:flutter/material.dart' hide Card;
import 'package:truco_mobile/src/config/general_config.dart';
import 'package:truco_mobile/src/model/Card/card_model.dart';
import 'package:truco_mobile/src/widget/TrucoCard/truco_card.dart';

class BoardView extends StatelessWidget {
  final List<Card> cards;

  const BoardView({super.key, required this.cards});

  Widget buildRowOfCards(int startIndex, bool showFace) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) => buildCard(cards[startIndex + index], showFace)),
    );
  }

  Widget buildColumnOfCards(int startIndex, bool showFace) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) => buildCard(cards[startIndex + index], showFace)),
    );
  }

  Widget buildCard(Card card, bool showFace) {
    return TrucoCard(
      cardModel: card,
      showFace: showFace,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(50, 168, 82, 1.0),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildRowOfCards(0, false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildColumnOfCards(3, false),
                    const Spacer(flex: 5),
                    buildColumnOfCards(6, false),
                  ],
                ),
                buildRowOfCards(9, true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}