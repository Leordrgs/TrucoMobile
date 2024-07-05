import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:truco_mobile/src/view/main_page_view.dart';
import 'package:truco_mobile/src/widget/custom_button.dart';
import 'package:truco_mobile/src/widget/custom_text.dart';

class MyRegisterPage extends StatefulWidget {
  final String title;

  const MyRegisterPage({Key? key, required this.title}) : super(key: key);

  @override
  _MyRegisterPageState createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(nameController.text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyMainPagePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Erro ao registrar')));
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
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
                      CustomTextField(
                        controller: nameController,
                        hintText: "Digite seu nome...",
                        labelTextFontSize: 36,
                        hintTextFontSize: 20,
                        fontSize: 20,
                        labelText: "Nome",
                      ),
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
                        text: 'Salvar',
                        onPressed: _register,
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
