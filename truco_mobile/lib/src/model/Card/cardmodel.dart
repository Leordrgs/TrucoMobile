import 'package:truco_mobile/src/model/Card/card_model.dart';

class CardModel {
  final String code;
  final String image;
  final String value;
  final String suit;

  CardModel({
    required this.code,
    required this.image,
    required this.value,
    required this.suit,
  });

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      code: map['code'],
      image: map['image'],
      value: map['value'],
      suit: map['suit'],
    );
  }

  // Adicionando método de conversão de Card para CardModel
  factory CardModel.fromCard(Card card, String imagePath) {
    return CardModel(
      code: '${card.rank}${card.suit}',
      image: imagePath, // Caminho da imagem passado como argumento
      value: card.rank,
      suit: card.suit,
    );
  }
}
