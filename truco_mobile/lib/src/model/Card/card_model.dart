class Card {
  String rank;
  String suit;
  int value;

  Card({required this.rank, required this.suit, required this.value});

  int compareValue(Card other) {
    return value.compareTo(other.value);
  }

  @override
  String toString() {
    return '$rank de $suit';
  }

  Card.fromJson(Map<String, dynamic> json) : rank = json['rank'], suit = json['suit'], value = json['value'];

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'suit': suit,
      'value': value,
    };
  }
}
