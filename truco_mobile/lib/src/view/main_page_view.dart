import 'package:flutter/material.dart';
import 'package:truco_mobile/src/view/login_view.dart';
import 'package:truco_mobile/src/view/register_view.dart';
import 'package:truco_mobile/src/widget/custom_button.dart';

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
        width: MediaQuery.of(context).size.width,
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
                child: Image.asset('lib/src/assets/truco.png'),
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
