import 'package:flutter/material.dart' hide Table, Card;
import 'package:truco_mobile/src/view/loading_view.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MaterialApp(
    home: MyLoadingPage(title: 'Carregando'),
  ));
}