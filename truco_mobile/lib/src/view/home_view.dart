import 'package:flutter/material.dart';
import 'package:truco_mobile/src/view/create_game_view.dart';
import 'package:truco_mobile/src/view/game_list_view.dart';
import 'package:truco_mobile/src/view/login_view.dart';
import 'package:truco_mobile/src/widget/custom_button.dart';

class MyHomePagePage extends StatefulWidget {
    final String title;
  const MyHomePagePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePagePageState createState() => _MyHomePagePageState();
}

class _MyHomePagePageState extends State<MyHomePagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(style: TextStyle(color: Colors.white), 'Tela inicial'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyLoginPage(title: 'Login',))),
        ),
      ),
      body: Container(
        color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5),
                width: 300,
                height: 286,
                child: Image.asset('lib/src/assets/truco.png'),
              ),
              SizedBox(height: 20), 
              CustomButton(
                text: 'Criar jogo',
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyCreateNewGamePage(title: 'Login'))),
                width: 200,
                height: 50,
                fontSize: 32,
              ),
              SizedBox(height: 10), 
              CustomButton(
                text: 'Ver salas',
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GameListView(title: 'Ver salas'))),
                width: 200,
                height: 50,
                fontSize: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
