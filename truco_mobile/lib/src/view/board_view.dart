import 'package:flutter/material.dart';
import 'package:truco_mobile/src/controller/game_controller.dart';
import 'package:truco_mobile/src/model/cardmodel.dart';
import 'package:truco_mobile/src/model/player_model.dart';
import 'package:truco_mobile/src/widget/score_board.dart';
import 'package:truco_mobile/src/widget/truco_card.dart';

class BoardView extends StatefulWidget {
  final GameController gameController;

  BoardView({Key? key, required this.gameController}) : super(key: key);

  @override
  _BoardViewState createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  List<CardModel> playedCards = [];
  CardModel? selectedCard;
  bool showPlayPrompt = false;
  int playerToPlay = 0;
  CardModel? manilha;
  void startGame() async {
    var gameData = await widget.gameController.startGame();
    setState(() {
      manilha = (gameData as Map)['manilha'];
    });
  }

  @override
  void initState() {
    super.initState();
    startGame();
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

  void onCenterTap() {
    if (showPlayPrompt && selectedCard != null) {
      setState(() {
        playedCards.add(selectedCard!);
        widget.gameController.players[playerToPlay].hand.remove(selectedCard);
        selectedCard = null;
        showPlayPrompt = false;
      });
      switchPlayer();
    } else if (selectedCard != null) {
      setState(() {
        showPlayPrompt = false;
      });
    }
  }

  Widget buildCard(CardModel card, bool isManilhaCard, bool isHidden,
      {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Transform.scale(
        scale: isSelected ? 1.2 : 1.0,
        child: TrucoCard(
          cardModel: card,
          isHidden: isHidden,
          width: 50,
          height: 80,
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
        onTap: onCenterTap,
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
          children: playedCards.map((card) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: TrucoCard(
                cardModel: card,
                isHidden: false,
                width: 40,
                height: 60,
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
                onTap: onCenterTap,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildRowOfCards(widget.gameController.players[1], true),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(flex: 5),
                        ],
                      ),
                      buildRowOfCards(widget.gameController.players[0], false),
                    ],
                  ),
                ),
              ),
              if (manilha != null) buildManilhaCard(),
              if (showPlayPrompt) buildPlayPrompt(),
              buildPlayedCards(),
              Positioned(
                top: 120.0,
                left: 0,
                child: Container(
                  width: 160.0,
                  height: 100.0,
                  child: FittedBox(
                    alignment: Alignment.topLeft,
                    child: ScoreBoard(
                      scoreTeamA: 10,
                      scoreTeamB: 7,
                      color: Colors.black,
                      fontColor: Colors.white,
                      size: 12.0,
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
