import 'package:flutter/material.dart';
import 'package:truco_mobile/src/view/HomeView/home_view.dart';
import 'package:truco_mobile/src/widget/CustomButton/custom_button.dart';

class MyCreateNewGamePage extends StatefulWidget {
  final String title;
  const MyCreateNewGamePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyCreateNewGamePage createState() => _MyCreateNewGamePage();
}

class _MyCreateNewGamePage extends State<MyCreateNewGamePage> {
  bool _isPaulista = true;
  int _totalPlayers = 2;

  void _navigateBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyHomePagePage(title: 'Tela inicial')),
    );
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

  Widget _buildCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isPaulista,
          onChanged: (bool? value) {
            setState(() {
              _isPaulista = value ?? false;
            });
          },
          activeColor: Colors.red,
          checkColor: Colors.white,
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
      ),
    );
  }

  Widget _buildRadioButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
          '2x2',
          style: TextStyle(color: Colors.white),
        ),
        Radio<int>(
          value: 1,
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
        borderRadius: BorderRadius.circular(16.0), // Aplicando borderRadius
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
            _buildCheckbox(),
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
                onPressed: () => {},
                text: 'Convidar jogadores',
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
