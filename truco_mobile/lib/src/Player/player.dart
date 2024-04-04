import 'package:truco_mobile/src/Dealer/dealer.dart';
import 'package:truco_mobile/src/Deck/deck.dart';
import 'package:truco_mobile/src/Card/card.dart';

class Players extends Dealer {
  
  String name;
  List<Card> hand = [];

  Players({required this.name, required this.hand});

  @override
  String toString() {
    return '$name: $hand';
  }
}