import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truco_mobile/src/config/error_message.dart';
import 'package:truco_mobile/src/widget/custom_toast.dart';

class DatabaseService {
  
  createTrucoGame(String gameName, gameType, totalPlayers) async {
    try {
      CollectionReference games =
          FirebaseFirestore.instance.collection('games');
      await games.add({
        'name': gameName,
        'isPaulista': gameType,
        'totalPlayers': totalPlayers,
        'createdAt': FieldValue.serverTimestamp(),
        'players': [],
      });
      genericToast(gameCreateSucessuful, Colors.green, Colors.white);
    } catch (e) {
      genericToast(gameCreateError, Colors.green, Colors.white);
      debugPrint('Erro ao criar a partida: $e');
    }
  }
}
