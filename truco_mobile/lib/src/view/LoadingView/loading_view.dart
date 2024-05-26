import 'package:flutter/material.dart';
import 'package:truco_mobile/src/view/MainView/main_page_view.dart';

class MyLoadingPage extends StatefulWidget {
  final String title;

  const MyLoadingPage({Key? key, required this.title}) : super(key: key);

  @override
  _MyLoadingPageState createState() => _MyLoadingPageState();
}

class _MyLoadingPageState extends State<MyLoadingPage> {
  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  void _simulateLoading() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => MyMainPagePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.red,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 350,
                  width: 350,
                  child: Image.network(
                    'https://gifs.eco.br/wp-content/uploads/2023/11/imagens-de-truco-png-0.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
