class Card {

  String suit;
  int value;
  
  Card({required this.suit, required this.value});

  @override
  String toString() {
    return '$value de $suit';
  }
}