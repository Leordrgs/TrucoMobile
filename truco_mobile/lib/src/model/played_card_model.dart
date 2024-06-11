import 'package:truco_mobile/src/model/card_model.dart';
import 'package:truco_mobile/src/model/player_model.dart';

class PlayedCard {
  final PlayerModel player;
  final CardModel card;

  PlayedCard(this.player, this.card);

  @override
  String toString() {
    return 'PlayedCard[{player: $player, card: $card]}';
  }
}