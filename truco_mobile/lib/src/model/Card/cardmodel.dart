class CardModel {
  final String code;
  final String image;
  final String value;
  final String suit;

  CardModel({required this.code, required this.image, required this.value, required this.suit});

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      code: map['code'],
      image: map['image'],
      value: map['value'],
      suit: map['suit'],
    );
  }
}