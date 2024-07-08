import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truco_mobile/src/controller/game_controller_provider.dart';
import 'package:truco_mobile/src/model/card_model.dart';
import 'package:truco_mobile/src/model/played_card_model.dart';
import 'package:truco_mobile/src/model/player_model.dart';
import 'package:truco_mobile/src/model/turn_model.dart';
import 'package:truco_mobile/src/widget/custom_toast.dart';
import 'package:truco_mobile/src/widget/score_board.dart';
import 'package:truco_mobile/src/widget/truco_card.dart';

class BoardView extends StatefulWidget {
  final String gameId;
  final int totalPlayers;

  BoardView({Key? key, required this.gameId, required this.totalPlayers})
      : super(key: key);

  @override
  _BoardViewState createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  CardModel? selectedCard;
  bool showPlayPrompt = false;
  TurnModel? turnModel;
  CardModel? manilha;
  List<PlayedCard> playedCards = [];
  String deckId = '';
  bool isLoading = true;
  bool isGameStarted = false;

  // void startGame(roomID, GameControllerProvider gameController, [bool newGame = false]) async {
   
  //   var gameData = await gameController.manageGame(roomID, newGame, widget.totalPlayers);
  //   deckId = (gameData as Map)['deckId'];
  //   setState(() {
  //     manilha = (gameData)['manilha'];
  //     turnModel = TurnModel(turnNumber: 0, players: gameController.players);
  //     isLoading = false;
  //   });
  // }

    void checkGameStatus(String deckId, GameControllerProvider gameController) {
    if (gameController.isGameFinished()) {
      gameController.returnCardsAndShuffle(deckId);
      gameController.currentRound = 0;
      for (var player in gameController.players) {
        player.hand.clear();
        player.resetRoundWins();
        player.roundsWinsCounter = 0;
      }
      startGameTransaction(widget.gameId, gameController);
    }

    if (gameController.players[0].score == 12) {
      showGameWinnerToast(gameController.players[0].name);
    } else if (gameController.players[1].score == 12) {
      showGameWinnerToast(gameController.players[1].name);
    }
  }

  @override
  void initState() {
    super.initState();
    // Começa a verificar os jogadores assim que o widget é inicializado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _waitForPlayers();
    });
  }

  Future<void> _waitForPlayers() async {
    CollectionReference games = FirebaseFirestore.instance.collection('games');
    games.doc(widget.gameId).snapshots().listen((DocumentSnapshot snapshot) {
      var data = snapshot.data() as Map<String, dynamic>;
      var players = data['players'] as List<dynamic>;
      var gameController = Provider.of<GameControllerProvider>(context, listen: false);

      if (players.length == widget.totalPlayers && !isGameStarted) {
        isGameStarted = true;
        setState(() {
          gameController.players = players.map((player) => PlayerModel.fromMap(player)).toList();
        });
        games.doc(widget.gameId).update({'gameStarted': true});
        startGameTransaction(widget.gameId, gameController);
      } else {
        gameController.players =
            players.map((player) => PlayerModel.fromMap(player)).toList();
      }
    });
  }

  Future<void> startGameTransaction(String roomId, GameControllerProvider gameController) async {
  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentReference gameRef = FirebaseFirestore.instance.collection('games').doc(roomId);
    DocumentSnapshot snapshot = await transaction.get(gameRef);
    var data = snapshot.data() as Map<String, dynamic>;
    var players = data['players'] as List<dynamic>;
    var totalPlayers = data['totalPlayers'];
    print('VALIDAÇÂO PARA INICAR JOGO ${!data.containsKey('gameStarted') || !data['gameStarted']}');
    print('DATA DO GAME START -> ${data}');
    if (!data.containsKey('gameStarted') || !data['gameStarted'] || players.length == totalPlayers) {
      var gameData = await gameController.manageGame(roomId, false, widget.totalPlayers, true) as Map;

      transaction.update(gameRef, {
        'gameStarted': true,
        'deckId': gameData['deckId'],
        'manilha': gameData['manilha'],
        'cards': gameData['cards'],
      });

      if (!mounted) return;

      setState(() {
        deckId = gameData['deckId'];
        manilha = gameData['manilha'];
        turnModel = TurnModel(turnNumber: 0, players: gameController.players);
        isLoading = false;
      });
    }
  });
}

  void onCardTap(CardModel card, PlayerModel player,
      GameControllerProvider gameController) {
    if (turnModel!.getCurrentPlayer() == player) {
      setState(() {
        selectedCard = card;
        showPlayPrompt = true;
      });
    } else {
      showIsNotYourTurn(player.name);
    }
  }

  void handleCenterTap(GameControllerProvider gameController) {
    if (showPlayPrompt && selectedCard != null) {
      processPlayerMove();
      if (isNumberOfCardEqualNumbersOfPlayers(gameController)) {
        processRoundEnd(gameController);
      } else {
        switchPlayer();
      }
    } else if (selectedCard != null) {
      hidePlayPrompt();
    }

    checkGameStatus(deckId, gameController);
  }

  void processPlayerMove() {
    setState(() {
      var currentPlayer = turnModel!.getCurrentPlayer();
      var playedCard = PlayedCard(currentPlayer, selectedCard!);
      playedCards.add(playedCard);
      currentPlayer.hand.remove(selectedCard);
      selectedCard = null;
      showPlayPrompt = false;
    });
  }

  void processRoundEnd(GameControllerProvider gameController) {
    setState(() {
      var highestRankCard = gameController.processPlayedCards(playedCards);
      var roundWinner = gameController.checkWhoWins(
          highestRankCard, gameController.currentRound);
      turnModel!.recordRoundWinner(roundWinner);
      playedCards.clear();
      turnModel!.startNextRound();
    });
  }

  void switchPlayer() {
    setState(() {
      turnModel!.nextTurn();
    });
  }

  void hidePlayPrompt() {
    setState(() {
      showPlayPrompt = false;
    });
  }

  bool isNumberOfCardEqualNumbersOfPlayers(
      GameControllerProvider gameController) {
    return playedCards.length == gameController.players.length;
  }

  Widget buildCard(CardModel card, bool isManilhaCard, bool isHidden,
      PlayerModel player, GameControllerProvider gameController,
      {bool isSelected = false}) {
    if (isManilhaCard) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: TrucoCard(
          cardModel: card,
          isHidden: isHidden,
          width: 60,
          height: 90,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: GestureDetector(
        onTap: () => onCardTap(card, player, gameController),
        child: AnimatedScale(
          scale: isSelected ? 1.2 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: TrucoCard(
            cardModel: card,
            isHidden: isHidden,
            width: 60,
            height: 90,
          ),
        ),
      ),
    );
  }

  Widget buildRowOfCards(PlayerModel player, bool isHidden,
      GameControllerProvider gameController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) {
          if (index < player.hand.length) {
            return buildCard(
                player.hand[index], false, isHidden, player, gameController,
                isSelected: player.hand[index] == selectedCard);
          } else {
            return const SizedBox(
              width: 70.0,
              height: 100.0,
            );
          }
        },
      ),
    );
  }

  Widget buildManilhaCard(GameControllerProvider gameController) {
    return Positioned(
      top: 120,
      right: 10,
      child: buildCard(
          manilha!, true, false, gameController.players[0], gameController),
    );
  }

  Widget buildPlayPrompt(GameControllerProvider gameController) {
    return Center(
      child: GestureDetector(
        onTap: () => handleCenterTap(gameController),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.black.withOpacity(0.5),
          alignment: Alignment.center,
          child: const Text(
            'Clique aqui',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPlayedCards() {
    return Positioned(
      left: MediaQuery.of(context).size.width / 2 - 80,
      top: MediaQuery.of(context).size.height / 2 - 60,
      child: SizedBox(
        width: 160,
        height: 160,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: -8,
          runSpacing: -8,
          children: playedCards.map((playedCard) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: TrucoCard(
                cardModel: playedCard.card,
                player: playedCard.player,
                isHidden: false,
                width: 50,
                height: 70,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameControllerProvider>(
      builder: (context, gameController, child) {
        if (isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: const Color.fromRGBO(50, 168, 82, 1.0),
              body: SafeArea(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () => handleCenterTap(gameController),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(gameController.players[1].name),
                                buildRowOfCards(gameController.players[1],
                                    false, gameController),
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Spacer(flex: 5),
                              ],
                            ),
                            Column(
                              children: [
                                Text(gameController.players[0].name),
                                buildRowOfCards(gameController.players[0],
                                    false, gameController),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (manilha != null) buildManilhaCard(gameController),
                    if (showPlayPrompt) buildPlayPrompt(gameController),
                    buildPlayedCards(),
                    Positioned(
                      top: 140.0,
                      left: 0,
                      child: Container(
                        width: 160.0,
                        height: 100.0,
                        child: FittedBox(
                          alignment: Alignment.topLeft,
                          child: ScoreBoard(
                            scoreTeamA: gameController.players[0].score,
                            scoreTeamB: gameController.players[1].score,
                            playerA: gameController.players[0].name,
                            playerB: gameController.players[1].name,
                            roundOneWinnerA:
                                gameController.players[0].roundOneWin,
                            roundOneWinnerB:
                                gameController.players[1].roundOneWin,
                            roundTwoWinnerA:
                                gameController.players[0].roundTwoWin,
                            roundTwoWinnerB:
                                gameController.players[1].roundTwoWin,
                            roundThreeWinnerA:
                                gameController.players[0].roundThreeWin,
                            roundThreeWinnerB:
                                gameController.players[1].roundThreeWin,
                            color: Colors.black,
                            fontColor: Colors.white,
                            size: 12.0,
                            roundWinner: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
