import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:truco_mobile/src/view/home_view.dart';
import 'package:truco_mobile/src/view/main_page_view.dart';
import 'package:truco_mobile/src/widget/custom_button.dart';
import 'package:truco_mobile/src/widget/custom_text.dart';

class MyLoginPage extends StatefulWidget {
  final String title;

  const MyLoginPage({Key? key, required this.title}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isDevelopment = false;
  Future<void> _login() async {
    
    if (isDevelopment) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePagePage(title: 'Tela inicial')));
    }
    
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePagePage(title: 'Tela inicial')),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Mostrar um erro se o login falhar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Erro ao fazer login')));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyMainPagePage())),
        ),
      ),
      body: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5),
                width: 276,
                height: 264,
                 child: Image.asset('lib/src/assets/truco.png'),
              ),
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 30),
                      CustomTextField(
                        controller: emailController,
                        hintText: "Digite seu email...",
                        labelTextFontSize: 36,
                        hintTextFontSize: 20,
                        fontSize: 20,
                        labelText: "Email",
                      ),
                      SizedBox(height: 30),
                      CustomTextField(
                        controller: passwordController,
                        hintText: "Digite sua senha...",
                        labelTextFontSize: 36,
                        hintTextFontSize: 20,
                        fontSize: 20,
                        obscureText: true,
                        labelText: "Senha",
                      ),
                      SizedBox(height: 30),
                      CustomButton(
                        text: 'Entrar',
                        onPressed: _login,
                        width: 50,
                        height: 50,
                        fontSize: 36,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
