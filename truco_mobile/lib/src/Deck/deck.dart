import '../Card/card.dart';
import '../Card/card.dart';
import 'dart:math';

class Deck {

  List<Card> cards = [];

  List get getCards => cards;

  set setCards(List<Card> cards) {
    this.cards = cards;
  }

  generateDeck() {
    List<String> suits = ['Ouros', 'Copas', 'Espadas', 'Paus'];
    List<int> values = [1, 2, 3, 4, 5, 6, 7, 10, 11, 12];

    return suits
        .expand((suit) =>
            values.map((value) => Card(suit: suit, value: value)).toList())
        .toList();
  }

  shuffle(List deck) {
    List shuffledDeck = [];
    var randomNumber = Random();

    while (deck.length > 0) {
      var index = randomNumber.nextInt(deck.length);

      shuffledDeck.add(deck[index]);

      deck.removeAt(index);
    }

    return shuffledDeck;
  }

  @override
  String toString() {
    return '$getCards';
  }
}
