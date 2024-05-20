class CardModel {
  String rank;
  String suit;
  int value;

  CardModel({required this.rank, required this.suit, required this.value});

  int compareValue(CardModel other) {
    return value.compareTo(other.value);
  }

  @override
  String toString() {
    return '$rank de $suit';
  }

  CardModel.fromJson(Map<String, dynamic> json) : rank = json['rank'], suit = json['suit'], value = json['value'];

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'suit': suit,
      'value': value,
    };
  }
}
