import 'package:flutter/material.dart';
import 'package:truco_mobile/src/model/Card/cardmodel.dart';
import 'package:truco_mobile/src/widget/ScoreBoard/score_board.dart';
import 'package:truco_mobile/src/widget/TrucoCard/truco_card.dart';

class BoardView extends StatefulWidget {
  final List<CardModel> cards;

  const BoardView({Key? key, required this.cards}) : super(key: key);

  @override
  _BoardViewState createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  CardModel? selectedCard;
  bool showPlayPrompt = false;
  List<CardModel> playedCards = [];

  void onCardTap(CardModel card) {
    setState(() {
      selectedCard = card;
      showPlayPrompt = true;
    });
  }

  void onCenterTap() {
    if (showPlayPrompt && selectedCard != null) {
      setState(() {
        playedCards.add(selectedCard!);
        widget.cards.remove(selectedCard);
        selectedCard = null;
        showPlayPrompt = false;
      });
    } else if (selectedCard != null) {
      setState(() {
        showPlayPrompt = false;
      });
    }
  }

  Widget buildCard(CardModel card, bool isHidden, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () => onCardTap(card),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Transform.scale(
          scale: isSelected ? 1.2 : 1.0, 
          child: TrucoCard(
            cardModel: card,
            isHidden: isHidden,
          ),
        ),
      ),
    );
  }

  Widget buildRowOfCards(int startIndex, bool isHidden) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) {
          int cardIndex = startIndex + index;
          if (cardIndex < widget.cards.length) {
            return buildCard(widget.cards[cardIndex], isHidden,
                isSelected: widget.cards[cardIndex] == selectedCard);
          } else {
            return SizedBox(
              width: 70.0,
              height: 100.0,
            );
          }
        },
      ),
    );
  }

  Widget buildColumnOfCards(int startIndex, bool isHidden) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) {
          int cardIndex = startIndex + index;
          if (cardIndex < widget.cards.length) {
            return buildCard(widget.cards[cardIndex], isHidden,
                isSelected: widget.cards[cardIndex] == selectedCard);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildManilhaCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 110.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Carta virada',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  1,
                  (index) => buildCard(widget.cards[index], false),
                ),
              ),
            ),
          ],
        ),
      ),
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
            padding: const EdgeInsets.symmetric(horizontal:0),
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
                      buildRowOfCards(0, true),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildColumnOfCards(3, true),
                          const Spacer(flex: 5),
                          buildColumnOfCards(6, true),
                        ],
                      ),
                      buildRowOfCards(9, false),
                    ],
                  ),
                ),
              ),
              buildManilhaCard(),
              if (showPlayPrompt) buildPlayPrompt(),
              buildPlayedCards(),
              Positioned(
                top: 120.0,
                child: Container(
                  width: 160.0,
                  height: 100.0,
                  child: FittedBox(
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
