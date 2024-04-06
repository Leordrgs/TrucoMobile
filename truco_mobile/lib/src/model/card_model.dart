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
  Card.fromJson(Map<String, dynamic> json) 
  : rank = json['rank'],
    suit = json['suit'],
    value = json['value'];

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'suit': suit,
      'value': value,
    };
  }  
}
