import 'package:truco_mobile/src/config/general_config.dart';
import 'package:truco_mobile/src/model/cardmodel.dart';
import 'package:truco_mobile/src/model/player_model.dart';
import 'package:truco_mobile/src/service/api_service.dart';
import 'package:truco_mobile/src/view/board_view.dart';

class GameController {
  late List<PlayerModel> players;
  ApiService apiService = ApiService(baseUrl: DECK_API);
  GameController({required this.players});

  Future<Object> startGame() async {
    //create deck things here
    var deck = await apiService.createNewDeck(DECK_API_CARDS);
    var deckId = deck['deck_id'];
    var drawnCards = await apiService.drawCards(deckId, 6);
    var manilha = await apiService.drawCards(deckId, 1);
    print('AQUI È A MANILHA $manilha');
    //distribute the cards
    for (var i = 0; i < drawnCards['cards'].length; i++) {
      CardModel card = CardModel.fromMap(drawnCards['cards'][i]);
      players[i % players.length].hand.add(card);
    }

    //adjust the cards rank if is manilha cards
    adjustCardsRankByManilha(players, CardModel.fromMap(manilha['cards'][0]));

    //zero the points
    for (var i = 0; i < players.length; i++) {
      players[i].score = 0;
    }

    //return an object with the deckId, the manilha and the cards
    var obj = {
      'deckId': deckId,
      'manilha': CardModel.fromMap(manilha['cards'][0]),
      'cards': (drawnCards['cards'] as List)
          .map((item) => CardModel.fromMap(item))
          .toList(),
    };


    return obj;
  }

  bool isCardValueEqualToNextValue(int manilhaRank, nextValue) {

    return manilhaRank + 1 == nextValue;
  }


  void adjustCardsRankByManilha(List<PlayerModel> players, CardModel manilha) {
    players.forEach((player) {
      player.hand.forEach((card) {
        if (isCardValueEqualToNextValue(manilha.rank, card.rank)) {

          card.rank = CardModel.adjustCardValue(card);
        }
      });
    });
  }

  Map<String, Object> processPlayedCards(List<PlayedCard> playedCards) {
    var cards = playedCards
        .map((playedCard) =>
            {'rank': playedCard.card.rank, 'player': playedCard.player})
        .toList();

    cards.sort((a, b) => (a['rank'] as Comparable).compareTo(b['rank']));

    var highestRankCard = cards.last;

    return highestRankCard;
  }

  void checkWhoWins(highestRankCard) {
    if (highestRankCard['player'] == players[0] && players[0].score < 12) {
      players[0].score++;
    } else {
      players[1].score++;
    }
  }

  // void playRound(playedCards) {
  //   int player1RoundWins = 0;
  //   int player2RoundWins = 0;

  //   for (int i = 0; i < 3; i++) {
  //     Map<String, Object> highestRankCard = processPlayedCards(playedCards);
  //     checkWhoWins(highestRankCard);

  //     if (highestRankCard['player'] == players[0]) {
  //       player1RoundWins++;
  //     } else {
  //       player2RoundWins++;
  //     }

  //     if (player1RoundWins == 2 || player2RoundWins == 2) {
  //       break;
  //     }
  //   }

  //   if (player1RoundWins > player2RoundWins) {
  //     players[0].score++;
  //   } else {
  //     players[1].score++;
  //   }
  // }
}
