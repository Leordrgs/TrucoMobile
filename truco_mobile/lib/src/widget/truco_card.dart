import 'package:flutter/material.dart' hide Card;
import 'package:truco_mobile/src/config/general_config.dart';
import 'package:truco_mobile/src/model/card_model.dart';
import 'package:truco_mobile/src/model/player_model.dart';

class TrucoCard extends StatelessWidget {
  final CardModel cardModel;
  final bool isHidden;
  final double width;
  final double height;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final PlayerModel? player;

  const TrucoCard({
    super.key,
    required this.cardModel,
    this.isHidden = true,
    this.width = 80,
    this.height = 110,
    this.margin = const EdgeInsets.all(10),
    this.padding = const EdgeInsets.all(10),
    this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: isHidden
                ? const DecorationImage(
                    image: NetworkImage(backCard),
                    fit: BoxFit.fill,
                  )
                : DecorationImage(
                    image: NetworkImage(cardModel.image),
                    fit: BoxFit.fill,
                  ),
          ),
          margin: margin,
          padding: padding,
        ),
        if (player != null)
          Positioned(
            right: 0,
            left: 0,
            top: -5,
            child: Text(
              player!.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black,
              ),
            ),
          ),
      ],
    );
  }
}
