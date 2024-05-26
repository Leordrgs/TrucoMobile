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
    Key? key,
    required this.cardModel,
    this.isHidden = true,
    this.width = 50,
    this.height = 80,
    this.margin = const EdgeInsets.all(10),
    this.padding = const EdgeInsets.all(5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = isHidden ? BACK_CARD : cardModel.image;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
      margin: margin,
      padding: padding,
    );
  }
}
