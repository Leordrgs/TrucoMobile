class Card {

  String suit;
  int value;
  
  Card({required this.suit, required this.value});

  int get getValue => value;

  set setValue(int value) {
    this.value = value;
  }

  String get getSuit => suit;

  set setSuit(String suit) {
    this.suit = suit;
  } 

  @override
  String toString() {
    return '$getValue de $getSuit';
  }
}