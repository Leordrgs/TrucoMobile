import 'package:flutter/material.dart';
import 'package:truco_mobile/src/config/error_message.dart';
import 'package:truco_mobile/src/config/general_config.dart';
import 'package:truco_mobile/src/model/card_model.dart';
import 'package:truco_mobile/src/service/api_service.dart';
import 'package:truco_mobile/src/service/database_service.dart';
import 'package:truco_mobile/src/view/home_view.dart';
import 'package:truco_mobile/src/widget/custom_button.dart';
import 'package:truco_mobile/src/widget/custom_toast.dart';

class MyCreateNewGamePage extends StatefulWidget {
  final String title;
  const MyCreateNewGamePage({super.key, required this.title});

  @override
  _MyCreateNewGamePageState createState() => _MyCreateNewGamePageState();
}

class _MyCreateNewGamePageState extends State<MyCreateNewGamePage> {
  bool _isPaulista = true;
  int _totalPlayers = 2;
  String _gameName = '';
  GameDatabaseManager gameDatabaseManager = GameDatabaseManager();
  ApiService apiService = ApiService(baseUrl: deckApi);

  void _navigateBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const MyHomePagePage(title: 'Tela inicial')),
    );
  }

  Future<void> _createGame() async {
    if (_gameName.isEmpty) {
      genericToast(needsGameName, Colors.red, Colors.white);
      return;
    }

    if (_totalPlayers == 2) {
      var deck = await apiService.createNewDeck(deckApiCards);
      var deckId = deck['deck_id'];
      var drawCards = await apiService.drawCards(deck['deck_id'], 6);
      var manilha = await apiService.drawCards(deckId, 1);
      var deckObj = {
        'deckId': deckId,
        'manilha': CardModel.fromMap(manilha['cards'][0]).toMap(),
        'cards': drawCards['cards'].map((item) => CardModel.fromMap(item).toMap()),
      };
      gameDatabaseManager.createTrucoGame(_gameName, _isPaulista, _totalPlayers, deckObj);
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Criar partida', style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => _navigateBack(context),
      ),
    );
  }

  Widget _buildGameTypeButton() {
    return Row(
      children: [
        Radio<bool>(
          value: true,
          groupValue: _isPaulista,
          onChanged: (bool? value) {
            setState(() {
              _isPaulista = value ?? false;
            });
          },
          activeColor: Colors.red,
        ),
        const Text(
          'Paulista',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Partida 01...',
          border: InputBorder.none,
        ),
        style: const TextStyle(color: Colors.black),
        onChanged: (value) {
          setState(() {
            _gameName = value;
          });
        },
      ),
    );
  }

  Widget _buildRadioButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio<int>(
          value: 4,
          groupValue: _totalPlayers,
          onChanged: (int? value) {
            setState(() {
              _totalPlayers = value!;
            });
          },
          activeColor: Colors.red,
        ),
        const Text(
          '2x2',
          style: TextStyle(color: Colors.white),
        ),
        Radio<int>(
          value: 2,
          groupValue: _totalPlayers,
          onChanged: (int? value) {
            setState(() {
              _totalPlayers = value!;
            });
          },
          activeColor: Colors.red,
        ),
        const Text(
          '1x1',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      width: 381,
      height: 457,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Configure a partida',
              style: TextStyle(color: Colors.white, fontSize: 24),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            const Text(
              'Tipo de jogo:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            _buildGameTypeButton(),
            const SizedBox(height: 20),
            const Text(
              'Nome da sala:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10),
            _buildTextField(),
            const SizedBox(height: 20),
            const Text(
              'Total de jogadores:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            _buildRadioButtons(),
            const SizedBox(height: 20),
            Center(
              child: CustomButton(
                onPressed: _createGame,
                text: 'Criar sala',
                width: 200,
                height: 50,
                fontSize: 16,
                color: Colors.white,
                textColor: Colors.black,
              ),
            ),
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
