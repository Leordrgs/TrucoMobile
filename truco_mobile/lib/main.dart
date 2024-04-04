import 'src/Card/card.dart';
import 'src/Deck/deck.dart';

void main() {
  Deck deck = new Deck();
  var deckOfCards = deck.generateDeck();
  var shuffledDeck = deck.shuffle(deckOfCards);
  
  print(shuffledDeck);
}
