import 'dart:async';
import 'package:truco_mobile/src/config/general_config.dart';
import 'package:truco_mobile/src/model/card_model.dart';
import 'package:truco_mobile/src/model/played_card_model.dart';
import 'package:truco_mobile/src/model/player_model.dart';
import 'package:truco_mobile/src/service/api_service.dart';
import 'package:truco_mobile/src/widget/custom_toast.dart';

class GameController {
  List<PlayerModel> players;
  int currentRound = 0;
  

  ApiService apiService = ApiService(baseUrl: DECK_API);

  GameController({required this.players});

  Future<Object> manageGame([bool? newGame = false]) async {

    var deck = await apiService.createNewDeck(DECK_API_CARDS);
    var deckId = deck['deck_id'];
    var drawnCards = await apiService.drawCards(deckId, 6);
    var manilha = await apiService.drawCards(deckId, 1);

    distributeCards(drawnCards);
    adjustCardsRankByManilha(players, CardModel.fromMap(manilha['cards'][0]));

    if (newGame != null && newGame) {
      resetPoints();
    }

    var obj = {
      'deckId': deckId,
      'manilha': CardModel.fromMap(manilha['cards'][0]),
      'cards': (drawnCards['cards'] as List)
          .map((item) => CardModel.fromMap(item))
          .toList(),
    };

    return obj;
  }

  bool isGameFinished() {
    return players[0].score < 12 && players[1].score < 12 && players[0].hand.isEmpty && players[1].hand.isEmpty;
  }

  bool verifyIfAnyPlayerWonTwoRounds() {
    for (var player in players) {
      if (player.hasWonTwoRounds()) {
        player.winGameAndResetRounds();
        return true;
      }
    }
    return false;
  }

  void distributeCards(drawnCards) {
    for (var i = 0; i < drawnCards['cards'].length; i++) {
      CardModel card = CardModel.fromMap(drawnCards['cards'][i]);
      players[i % players.length].hand.add(card);
    }
  }

  void markRoundAsWon(PlayerModel winningPlayer, int roundNumber) {
    winningPlayer.winRound(roundNumber);
    currentRound = roundNumber;
    currentRound++;
    print('Current Round --> $currentRound');
  }

  void resetPoints() {
    for (var i = 0; i < players.length; i++) {
      players[i].score = 0;
    }
  }

  void resetPlayersHand() {
    for (var i = 0; i < players.length; i++) {
      players[i].hand.clear();
      print('HAND DOS JOGADORES --> ${players[i].hand}');
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

    var card1Rank = cards[0]['rank'] as int;
    var card2Rank = cards[1]['rank'] as int;
    var rankDifference = card1Rank - card2Rank;

    if (rankDifference == 0) {
      return {
        'cards': [cards[0], cards[1]],
      };
    }

    cards.sort((a, b) => (a['rank'] as Comparable).compareTo(b['rank']));

    var highestRankCard = cards.last;
  
    return highestRankCard;
  }

  void returnCardsAndShuffle(deckId) async {
    await apiService.returnCardsToDeck(deckId);
    await apiService.shuffleDeck(deckId);
  }

  bool isHandFinished(List<PlayerModel> players, int roundNumber) {
    print('isHandFinished');
    return roundNumber == 2; //&& players[0].hand.isEmpty || players[1].hand.isEmpty;
  }

  bool checkTheRoundWinner(PlayerModel player, highestRankCard) {
    return highestRankCard['player'] == player && player.score < 12;
  }

  bool playerHasTwoRoundWins(PlayerModel player) {
    return player.roundsWinsCounter == 2;
  }

  bool isRoundTied(highestRankCard) {
    return highestRankCard['cards'].length == 2;
  }

  void checkWhoWins(highestRankCard, int roundNumber) {

    if (isHandFinished(players, roundNumber)) {
      players[0].resetRoundWins();
      players[1].resetRoundWins();
      resetPlayersHand();          
    }

    if (checkTheRoundWinner(players[0], highestRankCard)) {
      showRoundWinnerToast(roundNumber, highestRankCard);
      markRoundAsWon(players[0], roundNumber);
      players[0].roundsWinsCounter++;

      if (playerHasTwoRoundWins(players[0])) {
        players[0].score += 1;
        showHandWinnerToast(roundNumber, highestRankCard);
        players[0].roundsWinsCounter = 0;
        resetPlayersHand();
        print('checkTheRoundWinner palyer 1');
      }
    } else if (checkTheRoundWinner(players[1], highestRankCard)) {
      showRoundWinnerToast(roundNumber, highestRankCard);
      markRoundAsWon(players[1], roundNumber);
      players[1].roundsWinsCounter++;
      if (playerHasTwoRoundWins(players[1])) {
        players[1].score += 1;
        showHandWinnerToast(roundNumber, highestRankCard);
        players[1].roundsWinsCounter = 0;
        resetPlayersHand();
        print('checkTheRoundWinner player 2');
      }
    } else if (isRoundTied(highestRankCard)) {
      showTiedRoundToast(roundNumber);
      players[0].roundsWinsCounter++;
      players[1].roundsWinsCounter++;
      markRoundAsWon(players[0], roundNumber);
      markRoundAsWon(players[1], roundNumber);
      print('entrou no empate');
      print('round wins 0 --> ${players[0].roundsWinsCounter}');
      print('round wins --> ${players[1].roundsWinsCounter}');

      if (players[0].roundsWinsCounter == 2 || 
          players[1].roundsWinsCounter == 2
        ) {
        resetPlayersHand();
      }
    }
  }
}
