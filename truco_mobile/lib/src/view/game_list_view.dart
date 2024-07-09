import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truco_mobile/src/controller/game_controller_provider.dart';
import 'package:truco_mobile/src/model/card_model.dart';
import 'package:truco_mobile/src/model/player_model.dart';
import 'package:truco_mobile/src/service/database_service.dart';
import 'package:truco_mobile/src/view/board_view.dart';
import 'package:truco_mobile/src/view/home_view.dart';
import 'package:provider/provider.dart';

class GameListView extends StatefulWidget {
  final String title;

  const GameListView({Key? key, required this.title}) : super(key: key);

  @override
  _GameListViewState createState() => _GameListViewState();
}

class _GameListViewState extends State<GameListView> {
  List<Map<String, dynamic>> gameRooms = [];
  List<Map<String, dynamic>> filteredGameRooms = [];
  GameDatabaseManager gameDatabaseManager = GameDatabaseManager();

  @override
  void initState() {
    super.initState();
    _fetchGameRooms();
  }

  Future<void> _fetchGameRooms() async {
    List<Map<String, dynamic>> allData = await gameDatabaseManager.fetchGameRooms();

    setState(() {
      gameRooms = allData;
      filteredGameRooms = gameRooms;
    });
  }

  Future<void> _deleteGameRoom(String id) async {
    await gameDatabaseManager.deleteGameRoom(id);
    _fetchGameRooms();
  }

  void _navigateBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const MyHomePagePage(title: 'Tela inicial')),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Ver salas', style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => _navigateBack(context),
      ),
    );
  }

  void _filterRooms(String query) {
    final filtered = gameRooms.where((room) {
      final roomName = (room['name'] as String?)?.toLowerCase() ?? '';
      final searchLower = query.toLowerCase();
      return roomName.contains(searchLower);
    }).toList();

    setState(() {
      filteredGameRooms = filtered;
    });
  }

  Future<void> _joinGameRoom(String gameId, List<PlayerModel> players, int totalPlayers) async {
  User? user = FirebaseAuth.instance.currentUser;
  var result = await gameDatabaseManager.getGameCards(gameId);
  List<CardModel> hand = [];

  if (result is List) {
    // Verifica se cada item da lista é um Map antes de converter
    hand = result.where((item) => item is Map<String, dynamic>)
                 .map((item) => CardModel.fromMap(item as Map<String, dynamic>))
                 .take(3)
                 .toList();

    result = result.skip(3).toList(); // Remove os primeiros 3 itens
    await gameDatabaseManager.updateGameCards(gameId, result);
  }

  if (user != null) {
    PlayerModel newPlayer = PlayerModel(
      id: user.uid,
      name: user.displayName ?? 'Anônimo',
      hand: hand,
    );

    await gameDatabaseManager.joinGame(gameId, newPlayer);

    GameControllerProvider gameController = GameControllerProvider(players: players);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider<GameControllerProvider>.value(
              value: gameController,
            ),
          ],
          child: BoardView(
            gameId: gameId,
            totalPlayers: totalPlayers,
          ),
        ),
      ),
    );
  } else {
    print('Usuário não autenticado');
  }
}


  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: (query) => _filterRooms(query),
              decoration: const InputDecoration(
                hintText: 'Pesquisar',
                border: InputBorder.none,
              ),
            ),
          ),
          const Icon(Icons.search, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildGameList() {
    return ListView.builder(
      itemCount: filteredGameRooms.length,
      itemBuilder: (context, index) {
        final gameRoom = filteredGameRooms[index];
        List<PlayerModel> playerModels = (gameRoom['players'] as List<dynamic>?)
                ?.map<PlayerModel>((player) =>
                    PlayerModel.fromMap(player as Map<String, dynamic>))
                .toList() ??
            [];
        return _buildGameRoomItem(
            gameRoom['id'] as String? ?? '',
            gameRoom['name'] as String? ?? '',
            playerModels.length,
            gameRoom['totalPlayers'] as int? ?? 0,
            playerModels);
      },
    );
  }

  Widget _buildGameRoomItem(String id, String name, int players, int maxPlayers,
      List<PlayerModel> playerInGameRoom) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$players/$maxPlayers jogadores'),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteGameRoom(id),
            ),
          ],
        ),
        onTap: () async {
          await _joinGameRoom(id, playerInGameRoom, maxPlayers);
        },
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: 393,
      height: 710,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            _buildSearchBar(),
            Expanded(child: _buildGameList()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.red,
        child: Center(child: _buildContent()),
      ),
    );
  }
}
