import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truco_mobile/src/config/general_config.dart';
import 'package:truco_mobile/src/model/card_model.dart';
import 'package:truco_mobile/src/model/played_card_model.dart';
import 'package:truco_mobile/src/model/player_model.dart';
import 'package:truco_mobile/src/service/api_service.dart';
import 'package:truco_mobile/src/widget/custom_toast.dart';

class GameControllerProvider extends ChangeNotifier {
  List<PlayerModel> players;
  int currentRound = 0;
  final bool _gameStarted = false;
  final bool _newRound = false;
  CollectionReference games = FirebaseFirestore.instance.collection('games');
  ApiService apiService = ApiService(baseUrl: deckApi);
  GameControllerProvider({required this.players});

  bool get gameStarted => _gameStarted;
  set gameStarted(bool value) => _gameStarted;
  bool get newRound => _newRound;
  set newRound(bool value) => _newRound;

  Future<Object> manageGame(String roomId, bool newRound, totalPlayers,
      [bool? newGame = false]) async {
    print('Caminho 26');

    var deck;
    var drawnCards;
    var manilha;
    var cardsAsList;

    if (newGame == true) {
      deck = await apiService.createNewDeck(deckApiCards);
      var deckId = deck['deck_id'];
      drawnCards = await apiService.drawCards(deckId, 6);
      manilha = await apiService.drawCards(deckId, 1);
      cardsAsList = (drawnCards['cards'] as List)
          .map((item) => CardModel.fromMap(item))
          .toList();
      distributeCards(drawnCards);
      adjustCardsRankByManilha(players, CardModel.fromMap(manilha['cards'][0]));

      var gameData = {
        'deckId': deckId,
        'manilha': CardModel.fromMap(manilha['cards'][0]),
        'cards': cardsAsList,
      };

      await saveGameToFirestore(
          roomId,
          deckId,
          {
            'deckId': deckId,
            'manilha': CardModel.fromMap(manilha['cards'][0]).toMap(),
            'cards': cardsAsList.map((card) => card.toMap()).toList(),
          },
          newGame!,
          totalPlayers);
      notifyListeners();
      return gameData;
    } else {
      var gameDoc = await games.doc(roomId).get();
      if (gameDoc.exists && gameDoc.data() != null) {
        var gameData = gameDoc.data() as Map<String, dynamic>;
        var deckData = gameData['deck'] as Map<String, dynamic>;
        var manilha =
            CardModel.fromMap(deckData['manilha'] as Map<String, dynamic>);
        var cards = (deckData['cards'] as List)
            .map((cardData) =>
                CardModel.fromMap(cardData as Map<String, dynamic>))
            .toList();
        distributeCards({'cards': cards.map((card) => card.toMap()).toList()});
        adjustCardsRankByManilha(players, manilha);

        notifyListeners();
        return gameData;
      } else {
        throw Exception('Game data not found');
      }
    }
  }

  // void startNewRound(String roomId) async {
  //   newRound = true;

  //   var gameData = await manageGame(roomId, true);
  //   notifyListeners();
  // }

  /*bool isGameFinished() {
    print('Caminho 29');
    return players[0].score < 12 &&
        players[1].score < 12 &&
        players[0].hand.isEmpty &&
        players[1].hand.isEmpty;
  }*/

  bool verifyIfAnyPlayerWonTwoRounds() {
    print('Caminho 30');
    for (var player in players) {
      if (player.hasWonTwoRounds()) {
        print('Caminho 31');
        player.winGameAndResetRounds();
        return true;
      }
    }
    print('Caminho 32');
    return false;
  }

  void distributeCards(drawnCards) {
    print('Caminho 33');
    for (var i = 0; i < drawnCards['cards'].length; i++) {
      CardModel card = CardModel.fromMap(drawnCards['cards'][i]);
      players[i % players.length].hand.add(card);
    }
    notifyListeners();
  }

  void markRoundAsWon(PlayerModel winningPlayer, int roundNumber) {
    winningPlayer.winRound(roundNumber);
    currentRound = roundNumber;
    currentRound++;
    print('Caminho 34');
  }

  void resetPoints() {
    for (var i = 0; i < players.length; i++) {
      players[i].score = 0;
    }
    print('Caminho 35');
    notifyListeners();
  }

  void resetPlayersHand() {
    for (var i = 0; i < players.length; i++) {
      players[i].hand.clear();
    }
    print('Caminho 36');
    notifyListeners();
  }

  bool isCardValueEqualToNextValue(int manilhaRank, nextValue) {
    print('Caminho 37');
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
    print('Caminho 38');
    notifyListeners();
  }

  Map<String, Object> processPlayedCards(List<PlayedCard> playedCards) {
    print('Caminho 39');
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
    notifyListeners();
    return highestRankCard;
  }

  void returnCardsAndShuffle(deckId) async {
    print('Caminho 40');
    await apiService.returnCardsToDeck(deckId);
    await apiService.shuffleDeck(deckId);
    notifyListeners();
  }

  bool isHandFinished(List<PlayerModel> players, int roundNumber) {
    print('Caminho 41');
    return roundNumber == 2;
  }

  bool checkTheRoundWinner(PlayerModel player, highestRankCard) {
    print('Caminho 42');
    return highestRankCard['player'] == player && player.score < 12;
  }

  bool playerHasTwoRoundWins(PlayerModel player) {
    print('Caminho 43');
    return player.roundsWinsCounter == 2;
  }

  bool isRoundTied(highestRankCard) {
    print('Caminho 44');
    return highestRankCard['cards'].length == 2;
  }

  int checkWhoWins(highestRankCard, int roundNumber) {
    if (isHandFinished(players, roundNumber)) {
      players[0].resetRoundWins();
      players[1].resetRoundWins();
      resetPlayersHand();
      print('Caminho 45');
    }

    if (checkTheRoundWinner(players[0], highestRankCard)) {
      showRoundWinnerToast(roundNumber, highestRankCard);
      markRoundAsWon(players[0], roundNumber);
      players[0].roundsWinsCounter++;
      print('Caminho 46');

      if (playerHasTwoRoundWins(players[0])) {
        players[0].score += 1;
        showHandWinnerToast(roundNumber, highestRankCard);
        players[0].roundsWinsCounter = 0;
        resetPlayersHand();
        print('Caminho 47');
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
        print('Caminho 48');
      }
    }
    if (isRoundTied(highestRankCard)) {
      for (var player in players) {
        player.resetRoundWins();
      }
      showTiedRoundToast(roundNumber);
      print('Caminho 49');
    }

    notifyListeners();
    return highestRankCard['player'] as int;
  }

  bool isGameFinished(List<PlayerModel> players) {
    print('Caminho 50');
    for (var player in players) {
      if (player.score == 12) {
        return true;
      }
    }
    return false;
  }

  Future<void> saveGameToFirestore(String roomId, String deckId,
      Map<String, dynamic> gameData, bool newGame, int totalPlayers) async {
    print(
        'Saving game to Firestore... roomId $roomId deckId $deckId gameData $gameData');

    try {
      print('Caminho 53');
      await games.doc(roomId).update({
        'deck': {
          'deckId': deckId,
          'manilha': (gameData['manilha'] as CardModel).toMap(),
          'cards': (gameData['cards'] as List<CardModel>)
              .map((card) => card.toMap())
              .toList(),
        }
      }).catchError((error) async {
        print('Caminho 54');
        print('Error updating game: $error');
        await games.doc(roomId).set({
          'totalPlayers': totalPlayers,
          'deck': {
            'deckId': deckId,
            'manilha': (gameData['manilha'] as CardModel).toMap(),
            'cards': (gameData['cards'] as List<CardModel>)
                .map((card) => card.toMap())
                .toList(),
          }
        });
      });
    } catch (error) {
      print('Caminho 55');
      print('Error saving game: $error');
    }
    notifyListeners();
  }
}
