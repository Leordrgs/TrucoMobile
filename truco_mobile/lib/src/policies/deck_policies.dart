import 'package:truco_mobile/src/model/card_model.dart';

class DeckPolicies {

  bool isCountGreaterThanCardsLength(int count, List<Card> cards) {

    return count > cards.length;
  }

  bool isCountGreaterThanMaxCards(int count, int maxCards) {

    return count > maxCards;
  }

  bool isCardValueEqualToNextValue(Card card, int nextValue) {

    return card.value == nextValue;
  }

}