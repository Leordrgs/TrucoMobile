import 'deck_model.dart';
import 'trucoStatus_model.dart';
import 'player_model.dart';
import 'team_model.dart';
import 'card_model.dart';

class Table {
  late final Deck deck;
  late final Team team1;
  late final Team team2;
  late Player? currentHand;
  late Player? currentFoot;
  late List<Card> currentRoundCards;
  int currentRoundWinner = -1; // 0 para Team 1, 1 para Team 2, -1 para empate
  int currentTurn = 0; // 0 para Team 1, 1 para Team 2
  TrucoStatus trucoStatus = TrucoStatus.NOT_REQUESTED;
  

  Table() {
    deck = Deck();
    Player player1 = Player(name: 'Player 1');
    Player player2 = Player(name: 'Player 2');
    Player player3 = Player(name: 'Player 3');
    Player player4 = Player(name: 'Player 4');

    team1 = Team(name: 'Team 1', player1: player1, player2: player2);
    team2 = Team(name: 'Team 2', player1: player3, player2: player4);

    currentHand = player1;
    currentFoot = player3;
    currentRoundCards = [];
  }

  void nextTurn() {
    if (currentTurn == 0) {
      currentTurn = 1;
      currentHand = team2.player1;
      currentFoot = team1.player1;
    } else {
      currentTurn = 0;
      currentHand = team1.player1;
      currentFoot = team2.player1;
    }
  }

  void playCard(Card card) {
    if (currentHand!.hand.contains(card)) {
      currentHand!.playCard(card, this);  // Passando a instância atual de Table como argumento
    }
  }

  int determineRoundWinner() {
    Card highestCard = currentRoundCards[0];
    int winner = -1;

    for (int i = 1; i < currentRoundCards.length; i++) {
      if (currentRoundCards[i].compareValue(highestCard) > 0) {
        highestCard = currentRoundCards[i];
        winner = i;
      }
    }

    return winner;
  }

  void startNewRound() {
    currentRoundCards.clear();
    trucoStatus = TrucoStatus.NOT_REQUESTED;

    distributeCards();
    printPlayersCards();

    if (currentHand == team1.player1) {
      currentHand = team1.player2;
      currentFoot = team2.player1;
    } else {
      currentHand = team2.player2;
      currentFoot = team1.player1;
    }
  }

  void distributeCards() {
  List<Card> team1Cards = deck.dealCards(3);  // Distribui 3 cartas
  List<Card> team2Cards = deck.dealCards(3);  // Distribui 3 cartas

  team1.player1.receiveCard(team1Cards[0]);
  team1.player1.receiveCard(team1Cards[1]);
  team1.player1.receiveCard(team1Cards[2]);

  team1.player2.receiveCard(team1Cards[0]);
  team1.player2.receiveCard(team1Cards[1]);
  team1.player2.receiveCard(team1Cards[2]);

  team2.player1.receiveCard(team2Cards[0]);
  team2.player1.receiveCard(team2Cards[1]);
  team2.player1.receiveCard(team2Cards[2]);

  team2.player2.receiveCard(team2Cards[0]);
  team2.player2.receiveCard(team2Cards[1]);
  team2.player2.receiveCard(team2Cards[2]);
}


  void printPlayersCards() {
    print('Cartas da Dupla 1 - Jogador 1:');
    for (var card in team1.player1.showHand()) {
      print(card);
    }

    print('\nCartas da Dupla 1 - Jogador 2:');
    for (var card in team1.player2.showHand()) {
      print(card);
    }

    print('\nCartas da Dupla 2 - Jogador 1:');
    for (var card in team2.player1.showHand()) {
      print(card);
    }

    print('\nCartas da Dupla 2 - Jogador 2:');
    for (var card in team2.player2.showHand()) {
      print(card);
    }
  }

  void requestTruco() {
    if (trucoStatus == TrucoStatus.NOT_REQUESTED) {
      trucoStatus = TrucoStatus.REQUESTED;
      // Notificando os jogadores de que o truco foi solicitado
      team1.notifyPlayers("Truco foi solicitado!");
      team2.notifyPlayers("Truco foi solicitado!");
    } else if (trucoStatus == TrucoStatus.REQUESTED) {
      trucoStatus = TrucoStatus.REQUESTED_6_POINTS;
      // Notificando os jogadores de que o truco vale 6 pontos
      team1.notifyPlayers("Truco vale agora 6 pontos!");
      team2.notifyPlayers("Truco vale agora 6 pontos!");
    } else if (trucoStatus == TrucoStatus.REQUESTED_6_POINTS) {
      trucoStatus = TrucoStatus.REQUESTED_9_POINTS;
      // Notificando os jogadores de que o truco vale 9 pontos
      team1.notifyPlayers("Truco vale agora 9 pontos!");
      team2.notifyPlayers("Truco vale agora 9 pontos!");
    }
  }

  void respondToTruco(bool accept) {
    if (accept) {
      trucoStatus = TrucoStatus.ACCEPTED;
      // Notificando os jogadores de que o truco foi aceito
      team1.notifyPlayers("Truco foi aceito!");
      team2.notifyPlayers("Truco foi aceito!");
    } else {
      trucoStatus = TrucoStatus.REFUSED;
      // Notificando os jogadores de que o truco foi recusado
      team1.notifyPlayers("Truco foi recusado!");
      team2.notifyPlayers("Truco foi recusado!");
    }
  }

  void showScore() {
    print('\nPlacar:');
    print('${team1.name}: ${team1.getPoints()} pontos');  // Usando getPoints()
    print('\n${team2.name}: ${team2.getPoints()} pontos');  // Usando getPoints()
  }

  bool checkVictory() {
    if (team1.getPoints() >= 12 || team2.getPoints() >= 12) {  // Usando getPoints()
      return true;
    }
    return false;
  }
}
