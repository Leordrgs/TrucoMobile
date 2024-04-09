class Card {
  final String rank;
  final String suit;
  final int value;

  Card({required this.rank, required this.suit, required this.value});

  

  int compareValue(Card other, Card manilha) {
    int valueA = value;
    int valueB = other.value;

    if (this == manilha) {
      valueA += 10; // Aumenta o valor da manilha em 10 para torná-la a carta mais alta
    }

    if (other == manilha) {
      valueB += 10; // Aumenta o valor da manilha em 10 para torná-la a carta mais alta
    }

    if (valueA > valueB) {
      return 1;
    } else if (valueA < valueB) {
      return -1;
    } else {
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
