class Card {
  final String rank;
  final String suit;
  final int value;

  Card({required this.rank, required this.suit, required this.value});

  

  int compareValue(Card other) {
    if (value > other.value) {
      return 1;
    } else if (value < other.value) {
      return -1;
    } else {
      // Tratar caso de empate
      return 0;
    }
  }


  @override
  String toString() {
    return '$rank de $suit';
  }
}
