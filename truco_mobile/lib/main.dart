import './src/card.dart';
import './src/deck.dart';

void main() {
  Deck deck = Deck();
  var deckOfCards = deck.generateDeck();
  var shuffledDeck = deck.shuffle(deckOfCards);
  print(shuffledDeck);
}
