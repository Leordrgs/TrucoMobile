import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truco_mobile/src/controller/game_controller.dart';
import 'package:truco_mobile/src/model/player_model.dart';
import 'package:truco_mobile/src/view/board_view.dart';
import 'package:truco_mobile/src/view/home_view.dart';

class GameListView extends StatefulWidget {
  final String title;

  const GameListView({Key? key, required this.title}) : super(key: key);

  @override
  _GameListViewState createState() => _GameListViewState();
}

class _GameListViewState extends State<GameListView> {
  List<Map<String, dynamic>> gameRooms = [];
  List<Map<String, dynamic>> filteredGameRooms = [];

  @override
  void initState() {
    super.initState();
    _fetchGameRooms();
  }

  Future<void> _fetchGameRooms() async {
    CollectionReference games = FirebaseFirestore.instance.collection('games');
    QuerySnapshot querySnapshot = await games.get();
    final allData = querySnapshot.docs
        .map((doc) => ({...doc.data() as Map<String, dynamic>, 'id': doc.id}))
        .toList();

    setState(() {
      gameRooms = allData;
      filteredGameRooms = gameRooms;
    });
  }

  Future<void> _deleteGameRoom(String id) async {
    CollectionReference games = FirebaseFirestore.instance.collection('games');
    await games.doc(id).delete();
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

  Future<void> _joinGameRoom(
      String gameId, List<PlayerModel> players, int totalPlayers) async {
    User? user = FirebaseAuth.instance.currentUser;
    print(user);
    if (user != null) {

      PlayerModel newPlayer = PlayerModel(
        id: user.uid,
        name: user.displayName ?? 'Anônimo',
      );

      print('PLAYER --> $newPlayer');

      // Adiciona o novo jogador à lista de jogadores
      players.add(newPlayer);
      print({players});
      // Atualiza a sala de jogo no Firestore com o novo jogador
      CollectionReference games =
          FirebaseFirestore.instance.collection('games');
      await games.doc(gameId).update({
        'players': players.map((player) => player.toMap()).toList(),
      });

      print({games});

      GameController gameController = GameController(players: players);
      print({gameController});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BoardView(
            gameController: gameController,
            gameId: gameId,
            totalPlayers: totalPlayers,
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
