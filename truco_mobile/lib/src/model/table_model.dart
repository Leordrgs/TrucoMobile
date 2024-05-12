import 'deck_model.dart';
import 'trucoStatus_model.dart';
import 'player_model.dart';
import 'team_model.dart';
import 'card_model.dart';

class Table {
  late final Deck deck;
  late final List<Team> teams;
  late Player? currentHand; // -> mão atual, jogador que começa a rodada
  late Player? currentFoot; // -> pé, jogador que joga por último na rodada
  late List<Card> currentRoundCards;
  int currentRoundWinner =
      -1; // index do time vencedor da rodada, -1 para empate
  int currentTurn =
      0; // index do time que está jogando, 0 para time 1 e 1 para time 2
  Card? manilha; // Manilha do jogo
  TrucoStatus trucoStatus = TrucoStatus.NOT_REQUESTED;

  Table(List<Player> playerNames) {
    
    if (playerNames.length % 2 != 0) {

      throw Exception('Number of players must be even');
    }

    deck = Deck();
    List<Player> players =
        playerNames.map((name) => Player(name: '$name')).toList();

    teams = List<Team>.generate(
        playerNames.length ~/ 2,
        (i) => Team(
            name: 'Team ${i + 1}',
            players: [players[i * 2], players[i * 2 + 1]]));

    currentHand = players[0];
    currentFoot = players[players.length ~/ 2];
    currentRoundCards = [];

    /*distributeCards();
  printPlayersCards();
  generateManilha(); // Virar a manilha após distribuir as cartas*/
  }

  int getNumberOfTeams() {
    return teams.length;
  }

  void nextTurn() {
    // Calculate the index of the next team
    int nextTeamIndex = (currentTurn + 1) % getNumberOfTeams();

    // Update the current turn to the next team
    currentTurn = nextTeamIndex;

    // The hand is always the first player of the current team
    currentHand = teams[currentTurn].players[0];

    // Calculate the index of the team after the current team
    int followingTeamIndex = (currentTurn + 1) % getNumberOfTeams();

    // The foot is always the first player of the following team
    currentFoot = teams[followingTeamIndex].players[0];
  }

  void playCard(Card card) {
    if (currentHand!.getHand().contains(card)) {
      currentHand!.playCard(
          card, this); // Passando a instância atual de Table como argumento
      currentRoundCards.add(card);
      currentHand!.hand.remove(card);
      nextTurn();
    }
  }

  int determineRoundWinner() {
    if (currentRoundCards.isEmpty) {
      // Se não houver cartas na rodada, não há vencedor
      return -1;
    }

    Card highestCard = currentRoundCards[0];
    int winnerIndex = 0;

    // Percorre as cartas da rodada para encontrar a mais alta
    for (int i = 1; i < currentRoundCards.length; i++) {
      final currentCard = currentRoundCards[i];
      if (currentHand!.compareCardWithManilha(currentCard, manilha) > 0) {
        highestCard = currentCard;
        winnerIndex = i;
      }
    }

    return winnerIndex;
  }

  void startNewRound() {
    deck = Deck();
    Player player1 = Player(name: 'Player 1');
    Player player2 = Player(name: 'Player 2');
    Player player3 = Player(name: 'Player 3');
    Player player4 = Player(name: 'Player 4');

    List<Team> teams = [
      Team(name: 'Team 1', players: [player1, player2]),
      Team(name: 'Team 2', players: [player3, player4])
    ];

    currentRoundCards = [];

    distributeCards();
    printPlayersCards();
    generateManilha(); // Virar a manilha após distribuir as cartas
  }

  void distributeCards() {
    for (Team team in teams) {
      for (Player player in team.players) {
        List<Card> cards = deck.dealCards(3);
        for (Card card in cards) {
          player.receiveCard(card);
        }
      }
    }
  }

  void resetRound() {
    for (Team team in teams) {
      for (Player player in team.players) {
        player.hand.clear();
      }
    }

    deck.resetDeck();
  }

  void printPlayersCards() {
    print('Cartas da Dupla 1 - Jogador 1:');
    for (var card in teams[0].players[0].showHand()) {
      print(card);
    }

    print('\nCartas da Dupla 1 - Jogador 2:');
    for (var card in teams[0].players[1].showHand()) {
      print(card);
    }

    print('\nCartas da Dupla 2 - Jogador 1:');
    for (var card in teams[1].players[0].showHand()) {
      print(card);
    }

    print('\nCartas da Dupla 2 - Jogador 2:');
    for (var card in teams[1].players[1].showHand()) {
      print(card);
    }
  }

  void generateManilha() {
    Card randomCard = deck.getRandomCard();
    Object manilha = deck.generateManilha(randomCard);

    print('Manilha do jogo: $manilha');

    // Atualizar as regras do jogo para considerar a manilha como a carta mais alta
    // Você pode armazenar a manilha em uma variável de classe e usá-la ao comparar as cartas durante o jogo
  }

  void requestTruco() {
    Map<TrucoStatus, TrucoStatus> nextStatus = {
      TrucoStatus.NOT_REQUESTED: TrucoStatus.REQUESTED_3_POINTS,
      TrucoStatus.REQUESTED_3_POINTS: TrucoStatus.REQUESTED_6_POINTS,
      TrucoStatus.REQUESTED_6_POINTS: TrucoStatus.REQUESTED_9_POINTS,
      TrucoStatus.REQUESTED_9_POINTS: TrucoStatus.REQUESTED_12_POINTS,
    };

    Map<TrucoStatus, String> statusMessages = {
      TrucoStatus.REQUESTED_3_POINTS: "Truco foi solicitado!",
      TrucoStatus.REQUESTED_6_POINTS: "Truco vale agora 6 pontos!",
      TrucoStatus.REQUESTED_9_POINTS: "Truco vale agora 9 pontos!",
      TrucoStatus.REQUESTED_12_POINTS: "Truco vale agora 12 pontos!",
    };

    if (nextStatus.containsKey(trucoStatus)) {
      trucoStatus = nextStatus[trucoStatus]!;
      String? message = statusMessages[trucoStatus];
      teams.forEach((team) {
        team.notifyPlayers(message!);
      });
    }
  }

  void respondToTruco(bool accept) {
    Map<bool, TrucoStatus> statusMap = {
      true: TrucoStatus.ACCEPTED,
      false: TrucoStatus.REFUSED,
    };

    Map<bool, String> messageMap = {
      true: "Truco foi aceito!",
      false: "Truco foi recusado!",
    };

    trucoStatus = statusMap[accept]!;
    String? message = messageMap[accept];

    teams.forEach((team) {
      team.notifyPlayers(message!);
    });
  }

  void awardPointsToWinner() {
    int winnerIndex = determineRoundWinner();

    if (winnerIndex != -1) {
      if (winnerIndex == 0) {
        teams[0].addPoints(trucoStatus.pointsAwarded());
        currentRoundWinner = 0;
      } else if (winnerIndex == 1) {
        teams[1].addPoints(trucoStatus.pointsAwarded());
        currentRoundWinner = 1;
      }
    }
  }

  void checkGameWinner() {
    if (teams[0].getPoints() >= 12) {
      print("Dupla vencedora: ${teams[0].name}");
      resetGame();
    } else if (teams[1].getPoints() >= 12) {
      print("Dupla vencedora: ${teams[1].name}");
      resetGame();
    }
  }

  void resetGame() {
    teams[0].resetPoints();
    teams[1].resetPoints();
    startNewRound();
  }

  void showScore() {
    print('\nPlacar:');
    print('${teams[0].name}: ${teams[0].getPoints()} pontos'); // Usando getPoints()
    print('\n${teams[1].name}: ${teams[1].getPoints()} pontos'); // Usando getPoints()
  }

  void addCardToRound(Card card) {
    currentRoundCards.add(card);
    nextTurn();
  }

  bool checkVictory() {
    if (teams[0].getPoints() >= 12 || teams[1].getPoints() >= 12) {
      // Usando getPoints()
      return true;
    }
    return false;
  }

  Table.fromJson(Map<String, dynamic> json) {
    deck = Deck.fromJson(json['deck'] ?? {});
    teams[0] = Team.fromJson(json['team1'] ?? {});
    teams[1] = Team.fromJson(json['team2'] ?? {});
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
      'team1': teams[0].toJson(),
      'team2': teams[1].toJson(),
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
