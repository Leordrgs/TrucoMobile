import 'package:flutter/material.dart';
import 'package:truco_mobile/src/model/deck_model.dart';
import 'package:truco_mobile/src/model/player_model.dart';

class PlayerHand extends StatelessWidget {

  final Player player;
  final bool? showHand;
  final bool? vertical;
  final Deck deck;

  const PlayerHand({
    super.key,
    required this.player,
    this.showHand,
    this.vertical, 
    required this.deck
  })

  @override
  Widget build(BuildContext context) {
    bool isVertical = vertical ?? false;

    var deck = Deck();
    player.hand = deck.dealCards(3);

    return isVertical
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
        )

  }

}