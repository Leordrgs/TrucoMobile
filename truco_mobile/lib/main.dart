import 'package:flutter/material.dart' hide Table, Card;
import 'package:truco_mobile/src/config/general_config.dart';
import 'package:truco_mobile/src/model/Card/cardmodel.dart';
import 'package:truco_mobile/src/service/api_service.dart';
//import 'package:truco_mobile/src/model/Player/player_model.dart';
//import 'package:truco_mobile/src/model/Table/table_model.dart';
import 'package:truco_mobile/src/view/BoardView/table_board_view.dart';
import 'package:truco_mobile/src/view/LoadingView/loading_view.dart';
import 'package:truco_mobile/src/view/LoginView/login_view.dart';
import 'package:truco_mobile/src/view/MainPage/main_page_view.dart';
import 'package:truco_mobile/src/view/RegisterView/register_view.dart';
//import 'package:truco_mobile/src/view/game_screen.dart'; 

void main() async {
  // ApiService apiService = ApiService(baseUrl: DECK_API);
  // Map<String, dynamic> newDeck = await apiService.createNewDeck();
  // String deckId = newDeck['deck_id'];
  // var response = await apiService.drawCards(deckId, 12);
  // List<CardModel> cards = (response['cards'] as List).map((cardMap) => CardModel.fromMap(cardMap)).toList();

  // runApp(BoardView(cards: cards));

  runApp(MaterialApp(
    home: MyLoadingPage(title: 'Carregando'),
    ));
}
/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Table mesa = Table([Player(name: 'Player 1'), Player(name: 'Player 2'), Player(name: 'Player 3'), Player(name: 'Player 4')]);
    mesa.startNewRound();

    // Exibindo o placar
    mesa.showScore();

    // Verificando a vitória
    if (mesa.checkVictory()) {
      print('Jogo finalizado! Equipe vencedora: ${mesa.currentRoundWinner == 0 ? mesa.teams[0].name : mesa.teams[1].name}');
    }

    return MaterialApp(
      title: 'Truco Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(table: mesa),  // Passando a mesa para o GameScreen
    );
  }
}*/
