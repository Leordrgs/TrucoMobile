import 'package:flutter/material.dart';
import 'package:truco_mobile/src/controller/game_controller.dart';
import 'package:truco_mobile/src/model/card_model.dart';
import 'package:truco_mobile/src/model/played_card_model.dart';
import 'package:truco_mobile/src/model/player_model.dart';
import 'package:truco_mobile/src/widget/custom_toast.dart';
import 'package:truco_mobile/src/widget/score_board.dart';
import 'package:truco_mobile/src/widget/truco_card.dart';

class BoardView extends StatefulWidget {
  final GameController gameController;

  BoardView({Key? key, required this.gameController}) : super(key: key);

  @override
  _BoardViewState createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  CardModel? selectedCard;
  bool showPlayPrompt = false;
  int playerToPlay = 0;
  CardModel? manilha;
  List<PlayedCard> playedCards = [];
  int roundNumber = 0;
  String deckId = '';

  void startGame([bool newGame = false]) async {
    var gameData = await widget.gameController.manageGame(newGame);
    deckId = (gameData as Map)['deckId'];
    setState(() {
      manilha = (gameData)['manilha'];
    });
  }

  @override
  void initState() {
    super.initState();
    startGame(true);
  }

  void onCardTap(CardModel card) {
    setState(() {
      selectedCard = card;
      showPlayPrompt = true;
    });
  }

  void switchPlayer() {
    setState(() {
      playerToPlay = playerToPlay == 0 ? 1 : 0;
    });
  }

  void checkGameStatus(deckId) {
    if (widget.gameController.isGameFinished()) {
      widget.gameController.returnCardsAndShuffle(deckId);
      widget.gameController.currentRound = 0;
      for (var i = 0; i < widget.gameController.players.length; i++) {
        widget.gameController.players[i].hand.clear();
        widget.gameController.players[i].resetRoundWins();
        widget.gameController.players[i].roundsWinsCounter = 0;
      }
      startGame();
    }

    if (widget.gameController.players[0].score == 12) {
      showGameWinnerToast(widget.gameController.players[0].name);
    } else if (widget.gameController.players[1].score == 12) {
      showGameWinnerToast(widget.gameController.players[1].name);
    }
  }

  void handleCenterTap() {
    if (showPlayPrompt && selectedCard != null) {
      processPlayerMove();
      if (isNumberOfCardEqualNumbersOfPlayers()) {
        processRoundEnd();
      }
      switchPlayer();
    } else if (selectedCard != null) {
      hidePlayPrompt();
    }

    checkGameStatus(deckId);
  }

  void processPlayerMove() {
    setState(() {
      var playedCard = PlayedCard(
          widget.gameController.players[playerToPlay], selectedCard!);
      playedCards.add(playedCard);
      widget.gameController.players[playerToPlay].hand.remove(selectedCard);
      selectedCard = null;
      showPlayPrompt = false;
    });
  }

  void processRoundEnd() {
    setState(() {
      int roundNumber = widget.gameController.currentRound;
      var highestRankCard =
          widget.gameController.processPlayedCards(playedCards);
      widget.gameController.checkWhoWins(highestRankCard, roundNumber);
      playedCards.clear();
    });
  }

  void hidePlayPrompt() {
    setState(() {
      showPlayPrompt = false;
    });
  }

  bool isNumberOfCardEqualNumbersOfPlayers() {
    return playedCards.length == widget.gameController.players.length;
  }

  Widget buildCard(CardModel card, bool isManilhaCard, bool isHidden,
      {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: GestureDetector(
        onTap: () => onCardTap(card),
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

  Widget buildRowOfCards(PlayerModel player, bool isHidden) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) {
          if (index < player.hand.length) {
            return buildCard(player.hand[index], false, isHidden,
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

  Widget buildManilhaCard() {
    return Positioned(
      top: 120,
      right: 10,
      child: buildCard(manilha!, true, false),
    );
  }

  Widget buildPlayPrompt() {
    return Center(
      child: GestureDetector(
        onTap: handleCenterTap,
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(50, 168, 82, 1.0),
        body: SafeArea(
          child: Stack(
            children: [
              GestureDetector(
                onTap: handleCenterTap,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(widget.gameController.players[1].name),
                          buildRowOfCards(
                              widget.gameController.players[1], false),
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
                          Text(widget.gameController.players[0].name),
                          buildRowOfCards(
                              widget.gameController.players[0], false),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (manilha != null) buildManilhaCard(),
              if (showPlayPrompt) buildPlayPrompt(),
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
                      scoreTeamA: widget.gameController.players[0].score,
                      scoreTeamB: widget.gameController.players[1].score,
                      playerA: widget.gameController.players[0].name,
                      playerB: widget.gameController.players[1].name,
                      roundOneWinnerA:
                          widget.gameController.players[0].roundOneWin,
                      roundOneWinnerB:
                          widget.gameController.players[1].roundOneWin,
                      roundTwoWinnerA:
                          widget.gameController.players[0].roundTwoWin,
                      roundTwoWinnerB:
                          widget.gameController.players[1].roundTwoWin,
                      roundThreeWinnerA:
                          widget.gameController.players[0].roundThreeWin,
                      roundThreeWinnerB:
                          widget.gameController.players[1].roundThreeWin,
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
}
