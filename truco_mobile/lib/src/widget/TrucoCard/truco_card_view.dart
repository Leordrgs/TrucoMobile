import 'package:flutter/material.dart';
import 'package:truco_mobile/src/model/card_model.dart';

class TrucoCard extends StatelessWidget {
  
  final CardModel cardModel;
  final bool? showCard;

  const TrucoCard({
    super.key,
    required this.cardModel,
    this.showCard,
  });

  @override
  Widget build(BuildContext context) {
    bool visibleFace = showCard ?? false;

    return Container(
      width: 50,
      height: 50,
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      child: visibleFace
          ? Center(
              child: Text(
              cardModel.rank,
              style: const TextStyle(fontSize: 25),
            ))
          : null,
    );
  }

}