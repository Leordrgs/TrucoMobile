import 'package:flutter/material.dart';
import 'package:truco_mobile/src/view/LoginView/login_view.dart';
import 'package:truco_mobile/src/view/RegisterView/register_view.dart';
import 'package:truco_mobile/src/widget/CustomButton/custom_button.dart';

class MyMainPagePage extends StatefulWidget {
  const MyMainPagePage({Key? key}) : super(key: key);

  @override
  _MyMainPagePageState createState() => _MyMainPagePageState();
}

class _MyMainPagePageState extends State<MyMainPagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        width: double.infinity,
        child: Padding(
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
                child: Image.network(
                  'https://gifs.eco.br/wp-content/uploads/2023/11/imagens-de-truco-png-0.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20), 
              CustomButton(
                text: 'Entrar',
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyLoginPage(title: 'Login'))),
                width: 200,
                height: 50,
                fontSize: 32,
              ),
              SizedBox(height: 10), 
              CustomButton(
                text: 'Registrar',
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyRegisterPage(title: 'Registrar'))),
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
