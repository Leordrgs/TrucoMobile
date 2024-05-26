import 'package:flutter/material.dart';
import 'package:truco_mobile/src/view/MainView/main_page_view.dart';
import 'package:truco_mobile/src/widget/CustomButton/custom_button.dart';
import 'package:truco_mobile/src/widget/CustomTextInput/custom_text.dart';

class MyRegisterPage extends StatefulWidget {
  final String title;

  const MyRegisterPage({super.key, required this.title});

  @override
  _MyRegisterPage createState() => _MyRegisterPage();
}

class _MyRegisterPage extends State<MyRegisterPage> {
  String loginBox = "";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(style: TextStyle(color: Colors.white), widget.title),
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
                child: Image.network(
                  'https://gifs.eco.br/wp-content/uploads/2023/11/imagens-de-truco-png-0.png',
                  fit: BoxFit.cover,
                ),
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
                          labelText: "Nome"),
                      SizedBox(height: 30),
                      CustomTextField(
                          controller: emailController,
                          hintText: "Digite seu email...",
                          labelTextFontSize: 36,
                          hintTextFontSize: 20,
                          fontSize: 20,
                          labelText: "Email"),
                      SizedBox(height: 30),
                      CustomTextField(
                          controller: passwordController,
                          hintText: "Digite sua senha...",
                          labelTextFontSize: 36,
                          hintTextFontSize: 20,
                          fontSize: 20,
                          obscureText: true,
                          labelText: "Senha"),
                      SizedBox(height: 30),
                      CustomButton(
                        text: 'Salvar',
                        onPressed: () => print('Clicou'),
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