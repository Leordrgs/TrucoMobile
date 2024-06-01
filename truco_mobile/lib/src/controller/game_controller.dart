import 'dart:async';
import 'package:truco_mobile/src/config/general_config.dart';
import 'package:truco_mobile/src/model/cardmodel.dart';
import 'package:truco_mobile/src/model/player_model.dart';
import 'package:truco_mobile/src/service/api_service.dart';
import 'package:truco_mobile/src/view/board_view.dart';

class GameController {
  late List<PlayerModel> players;
  late int currentRound = 0;
  ApiService apiService = ApiService(baseUrl: DECK_API);
  GameController({required this.players});

  Future<Object> manageGame([bool newGame = false]) async {
    //create deck things here
    var deck = await apiService.createNewDeck(DECK_API_CARDS);
    var deckId = deck['deck_id'];
    var drawnCards = await apiService.drawCards(deckId, 6);
    var manilha = await apiService.drawCards(deckId, 1);

    //distribute the cards
    distributeCards(drawnCards);

    //adjust the cards rank if is manilha cards
    adjustCardsRankByManilha(players, CardModel.fromMap(manilha['cards'][0]));

    if (newGame != null && newGame) {
      resetPoints();
    }

    // if (!newGame) {
    //   if (currentRound == 2) {
    //       currentRound = 0;
    //   }
    // }

    // currentRound++;

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

  void distributeCards(drawnCards) {
    for (var i = 0; i < drawnCards['cards'].length; i++) {
      CardModel card = CardModel.fromMap(drawnCards['cards'][i]);
      players[i % players.length].hand.add(card);
    }
  }

  void markRoundAsWon(PlayerModel winningPlayer, int roundNumber) {
    print('markRoundAsWon');
    winningPlayer.winRound(roundNumber);
    currentRound = roundNumber;
    currentRound++;
    print('CURRENT ROUND: $currentRound');
  }

  void resetPoints() {
    for (var i = 0; i < players.length; i++) {
      players[i].score = 0;
    }
  }

  void resetPlayersHand() {
    for (var i = 0; i < players.length; i++) {
      players[i].hand = [];
    }
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

  void checkWhoWins(highestRankCard, int roundNumber) {
    if (roundNumber == 2 && players[0].hand.isEmpty ||
        players[1].hand.isEmpty) {
      players[0].resetRoundWins();
      players[1].resetRoundWins();
    }

    if (highestRankCard['player'] == players[0] && players[0].score < 12) {
      markRoundAsWon(players[0], roundNumber);
    } else if (highestRankCard['player'] == players[1] &&
        players[1].score < 12) {
      markRoundAsWon(players[1], roundNumber);
    }
  }
}
