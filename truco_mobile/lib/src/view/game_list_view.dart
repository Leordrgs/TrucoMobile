import 'package:flutter/material.dart';
import 'package:truco_mobile/src/config/general_config.dart';
import 'package:truco_mobile/src/service/api_service.dart';
import 'package:truco_mobile/src/view/board_view.dart';
import 'package:truco_mobile/src/view/home_view.dart';
import 'package:truco_mobile/src/model/cardmodel.dart';

class GameListView extends StatefulWidget {
  final String title;

  const GameListView({Key? key, required this.title}) : super(key: key);

  @override
  _GameListView createState() => _GameListView();
}

class _GameListView extends State<GameListView> {
  // TrucoController trucoController = TrucoController(apiService: ApiService(baseUrl: DECK_API));

  List<Map<String, dynamic>> gameRooms = [
    {'name': 'Sala 1', 'players': 4, 'maxPlayers': 4},
    {'name': 'Sala 2', 'players': 2, 'maxPlayers': 4},
    {'name': 'Sala 3', 'players': 3, 'maxPlayers': 4},
    {'name': 'Sala 4', 'players': 3, 'maxPlayers': 4},
    {'name': 'Sala 5', 'players': 2, 'maxPlayers': 4},
    {'name': 'Sala 6', 'players': 1, 'maxPlayers': 4},
    {'name': 'Sala 7', 'players': 3, 'maxPlayers': 4},
    {'name': 'Sala 8', 'players': 0, 'maxPlayers': 4},
    {'name': 'Sala 9', 'players': 1, 'maxPlayers': 4},
  ];

  List<Map<String, dynamic>> filteredGameRooms = [];

  @override
  void initState() {
    super.initState();
    filteredGameRooms = gameRooms;
  }

  void _navigateBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyHomePagePage(title: 'Tela inicial')),
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
              decoration: InputDecoration(
                hintText: 'Pesquisar',
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.search, color: Colors.black),
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
            gameRoom['name'], gameRoom['players'], gameRoom['maxPlayers']);
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
          // if (name == 'Sala 1') {
          //   List<CardModel> cards = await trucoController.fetchCards();
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => BoardView(cards: cards)),
          //   );
          // }
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
