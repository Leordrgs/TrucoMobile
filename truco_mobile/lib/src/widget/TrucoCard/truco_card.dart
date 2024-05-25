import 'package:flutter/material.dart' hide Card;
import 'package:truco_mobile/src/config/general_config.dart';
import 'package:truco_mobile/src/model/Card/cardmodel.dart';

class TrucoCard extends StatelessWidget {
  final CardModel cardModel;
  final bool isHidden;
  final double width;
  final double height;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const TrucoCard({
    super.key,
    required this.cardModel,
    this.isHidden = true,
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
        image: isHidden
            ? DecorationImage(
                image: NetworkImage(BACK_CARD),
                fit: BoxFit.fill,
              )
            : DecorationImage(
                image: NetworkImage(cardModel.image),
                fit: BoxFit.fill,
              ),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      margin: margin,
      padding: padding,
    );
  }
}
