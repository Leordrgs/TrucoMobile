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
  Card? manilha; // Manilha do jogo
  Card? selectedCard; // Adicione esta linha

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

  void startNewRound() {
    currentRoundCards.clear();
    trucoStatus = TrucoStatus.NOT_REQUESTED;

    resetRound();
    distributeCards();
    printPlayersCards();
    generateManilha(); // Virar a manilha após distribuir as cartas

    if (currentHand == team1.player1) {
      currentHand = team1.player2;
      currentFoot = team2.player1;
    } else {
      currentHand = team2.player2;
      currentFoot = team1.player1;
    }
  }

  void resetRound() {
    team1.player1.hand.clear();
    team1.player2.hand.clear();
    team2.player1.hand.clear();
    team2.player2.hand.clear();
    
    deck.resetDeck();    
  }

  void distributeCards() {
    List<Card> player1Cards = deck.dealCards(3); // Distribui 3 cartas
    List<Card> player2Cards = deck.dealCards(3); // Distribui 3 cartas
    List<Card> player3Cards = deck.dealCards(3); // Distribui 3 cartas
    List<Card> player4Cards = deck.dealCards(3); // Distribui 3 cartas

    team1.player1.receiveCard(player1Cards[0]);
    team1.player1.receiveCard(player1Cards[1]);
    team1.player1.receiveCard(player1Cards[2]);

    team1.player2.receiveCard(player2Cards[0]);
    team1.player2.receiveCard(player2Cards[1]);
    team1.player2.receiveCard(player2Cards[2]);

    team2.player1.receiveCard(player3Cards[0]);
    team2.player1.receiveCard(player3Cards[1]);
    team2.player1.receiveCard(player3Cards[2]);

    team2.player2.receiveCard(player4Cards[0]);
    team2.player2.receiveCard(player4Cards[1]);
    team2.player2.receiveCard(player4Cards[2]);
  }  

  void printPlayersCards() {
    print('Cartas da Dupla 1 - Jogador 1:');
    for (var card in team1.player1.hand) {
      print(card);
    }

    print('\nCartas da Dupla 1 - Jogador 2:');
    for (var card in team1.player2.hand) {
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

  void generateManilha() {
    Card manilha = deck.generateManilha();

    print('Manilha do jogo: $manilha');    
  }

  void playCard(Player player, Card card) {
    if (player.hand.contains(card)) {
      selectedCard = card; // Atualiza a carta selecionada
      player.playCard(card, this);
      currentRoundCards.add(card);
      selectedCard = null; // Limpa a carta selecionada após jogar
      nextTurn();
    }
  }

  int determineRoundWinner() {
  if (currentRoundCards.isEmpty) {
    return -1; // Retorna -1 se não houver cartas na rodada atual
  }

  Card highestCard = currentRoundCards[0];
  int winnerIndex = 0;

  for (int i = 1; i < currentRoundCards.length; i++) {
    if (currentRoundCards[i].compareValue(highestCard, manilha!) > 0) {
      highestCard = currentRoundCards[i];
      winnerIndex = i;
      }
    }
    return winnerIndex;
  }

  void nextTurn() {
    int winnerIndex = determineRoundWinner();
    if (winnerIndex != -1) {
      currentRoundWinner = winnerIndex;
      awardPointsToWinner();
      startNewRound(); // Inicie uma nova rodada após determinar o vencedor do turno
    } else {
      // Alternar entre os jogadores
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
  }

  void awardPointsToWinner() {
    int winnerIndex = determineMatchWinner();
    if (winnerIndex != -1) {
      if (winnerIndex == 0) {
        team1.addPoints(trucoStatus.pointsAwarded());
        currentRoundWinner = 0;
      } else if (winnerIndex == 1) {
        team2.addPoints(trucoStatus.pointsAwarded());
        currentRoundWinner = 1;
      }
    }
  } 

  void requestTruco() {
    if (trucoStatus == TrucoStatus.NOT_REQUESTED) {
      trucoStatus = TrucoStatus.REQUESTED_3_POINTS;
      // Notificando os jogadores de que o truco foi solicitado
      team1.notifyPlayers("Truco foi solicitado!");
      team2.notifyPlayers("Truco foi solicitado!");
    } else if (trucoStatus == TrucoStatus.REQUESTED_3_POINTS) {
      trucoStatus = TrucoStatus.REQUESTED_6_POINTS;
      // Notificando os jogadores de que o truco vale 6 pontos
      team1.notifyPlayers("Truco vale agora 6 pontos!");
      team2.notifyPlayers("Truco vale agora 6 pontos!");
    } else if (trucoStatus == TrucoStatus.REQUESTED_6_POINTS) {
      trucoStatus = TrucoStatus.REQUESTED_9_POINTS;
      // Notificando os jogadores de que o truco vale 9 pontos
      team1.notifyPlayers("Truco vale agora 9 pontos!");
      team2.notifyPlayers("Truco vale agora 9 pontos!");
    } else if (trucoStatus == TrucoStatus.REQUESTED_9_POINTS) {
      trucoStatus = TrucoStatus.REQUESTED_12_POINTS;
      // Notificando os jogadores de que o truco vale 12 pontos
      team1.notifyPlayers("Truco vale agora 12 pontos!");
      team2.notifyPlayers("Truco vale agora 12 pontos!");
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

  void checkGameWinner() {
    if (team1.getPoints() >= 12) {
      print("Dupla vencedora: ${team1.name}");
      resetGame();
    } else if (team2.getPoints() >= 12) {
      print("Dupla vencedora: ${team2.name}");
      resetGame();
    }
  }

  int determineMatchWinner() {
    int team1Wins = 0;
    int team2Wins = 0;

    for (int i = 0; i < 3; i++) {
      nextTurn();
      int winnerIndex = determineRoundWinner();

      if (winnerIndex == 0) {
        team1Wins++;
      } else if (winnerIndex == 1) {
        team2Wins++;
      }

      if (team1Wins == 2) return 0; // Team 1 venceu
      if (team2Wins == 2) return 1; // Team 2 venceu
    }

    return -1; // Empate
  }

  void resetGame() {
    team1.resetPoints();
    team2.resetPoints();
    startNewRound();
  }

  void showScore() {
    print('\nPlacar:');
    print('${team1.name}: ${team1.getPoints()} pontos'); // Usando getPoints()
    print('\n${team2.name}: ${team2.getPoints()} pontos'); // Usando getPoints()
  }

  bool checkVictory() {
    if (team1.getPoints() >= 12 || team2.getPoints() >= 12) {
      // Usando getPoints()
      return true;
    }
    return false;
  }

  Table.fromJson(Map<String, dynamic> json) {
    deck = Deck.fromJson(json['deck'] ?? {});
    team1 = Team.fromJson(json['team1'] ?? {});
    team2 = Team.fromJson(json['team2'] ?? {});
    currentRoundCards = (json['currentRoundCards'] as List)
        .map((e) => Card.fromJson(e))
        .toList();
    currentRoundWinner = json['currentRoundWinner'] ?? -1;
    currentTurn = json['currentTurn'] ?? 0;
    trucoStatus = TrucoStatus.values[json['trucoStatus'] ?? 0];
    manilha = json['manilha'] != null ? Card.fromJson(json['manilha']) : null;
    // Adicione outros atributos da classe Table, se existirem.
  }

  Map<String, dynamic> toJson() {
    return {
      'deck': deck.toJson(),
      'team1': team1.toJson(),
      'team2': team2.toJson(),
      'currentRoundCards':
          currentRoundCards.map((card) => card.toJson()).toList(),
      'currentRoundWinner': currentRoundWinner,
      'currentTurn': currentTurn,
      'trucoStatus': trucoStatus.index,
      'manilha': manilha?.toJson(),
      // Adicione outros atributos da classe Table, se existirem.
    };
  }
}