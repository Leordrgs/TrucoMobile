import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truco_mobile/src/controller/game_controller.dart';
import 'package:truco_mobile/src/model/player_model.dart';
import 'package:truco_mobile/src/view/board_view.dart';
import 'package:truco_mobile/src/view/home_view.dart';

class GameListView extends StatefulWidget {
  final String title;

  const GameListView({Key? key, required this.title}) : super(key: key);

  @override
  _GameListView createState() => _GameListView();
}

class _GameListView extends State<GameListView> {
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
    final allData = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    
    setState(() {
      gameRooms = allData;
      filteredGameRooms = gameRooms;
    });
  }

  void _navigateBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePagePage(title: 'Tela inicial')),
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
      final roomName = room['name'].toLowerCase();
      final searchLower = query.toLowerCase();
      return roomName.contains(searchLower);
    }).toList();

    setState(() {
      filteredGameRooms = filtered;
    });
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
        return _buildGameRoomItem(
            gameRoom['name'], gameRoom['players'].length, gameRoom['totalPlayers']);
      },
    );
  }

  Widget _buildGameRoomItem(String name, int players, int maxPlayers) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(name),
        trailing: Text('$players/$maxPlayers jogadores'),
        onTap: () async {
          if (name == 'Sala 1') {
            List<PlayerModel> players = [
              PlayerModel(name: 'Jogador 1'),
              PlayerModel(name: 'Jogador 2'),
            ];
            GameController gameController = GameController(players: players);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BoardView(gameController: gameController)),
            );
          }
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
