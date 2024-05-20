import 'package:flutter/material.dart' hide Card;
import 'package:truco_mobile/src/config/general_config.dart';
import '../../model/Card/card_model.dart';

class TrucoCard extends StatelessWidget {
  final Card cardModel;
  final bool showFace;
  final double width;
  final double height;
  final EdgeInsets margin;
  final EdgeInsets padding;
  
  const TrucoCard({
    super.key,
    required this.cardModel,
    this.showFace = true,
    this.width = 60,
    this.height = 90,
    this.margin = const EdgeInsets.all(10),
    this.padding = const EdgeInsets.all(5),
  });

  @override
Widget build(BuildContext context) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: showFace ? Colors.white : null,
      image: showFace ? null : DecorationImage(
        image: NetworkImage(BACK_CARD),
        fit: BoxFit.fill,
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.black,
        width: 2,
      ),
    ),
    margin: margin,
    padding: padding,
    child: Center(
      child: showFace ? Text('${cardModel.rank} de ${cardModel.suit}') : null,
    ),
  );
}
}
