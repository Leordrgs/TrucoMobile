import 'package:truco_mobile/src/config/general_config.dart';

class CardModel {
  String code;
  String image;
  String value;
  String suit;
  int rank = 0;

  CardModel(
      {required this.code,
      required this.image,
      required this.value,
      required this.suit,
      this.rank = 0});

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
        code: map['code'],
        image: map['image'],
        value: map['value'],
        suit: map['suit'],
        rank: calculateCardRank(map['value']));
  }

  @override
  String toString() {
    return 'CardModel{code: $code, image: $image, value: $value, suit: $suit, rank: $rank}';
  }

  static int calculateCardRank(String value) {
    print('VALUE $value');
    switch (value) {
      case '4':
        return 1;
      case '5':
        return 2;
      case '6':
        return 3;
      case '7':
        return 4;
      case 'QUEEN':
        return 5;
      case 'JACK':
        return 6;
      case 'KING':
        return 7;
      case 'ACE':
        return 8;
      case '2':
        return 9;
      case '3':
        return 10;
      default:
        return 0;
    }
  }

  int adjustCardValue(CardModel card) {
    switch (card.suit) {
      case 'DIAMONDS':
        return card.rank += 11;
      case 'SPADES':
        return card.rank += 12;
      case 'HEARTS':
        return card.rank += 13;
      case 'CLUBS':
        return card.rank += 14;
      default:
        return card.rank;
    }
  }
}
