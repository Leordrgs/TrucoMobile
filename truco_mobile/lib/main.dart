import 'package:flutter/material.dart' hide Table, Card;
import 'package:truco_mobile/src/config/general_config.dart';
import 'package:truco_mobile/src/model/cardmodel.dart';
import 'package:truco_mobile/src/service/api_service.dart';
//import 'package:truco_mobile/src/model/Player/player_model.dart';
//import 'package:truco_mobile/src/model/Table/table_model.dart';
import 'package:truco_mobile/src/view/board_view.dart';
import 'package:truco_mobile/src/view/loading_view.dart';
import 'package:truco_mobile/src/view/login_view.dart';
import 'package:truco_mobile/src/view/main_page_view.dart';
import 'package:truco_mobile/src/view/register_view.dart';
//import 'package:truco_mobile/src/view/game_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: MyLoadingPage(title: 'Carregando'),
  ));
}