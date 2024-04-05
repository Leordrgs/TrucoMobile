import 'package:truco_mobile/src/model/table_model.dart';

void main() {
  Table mesa = Table();

  mesa.startNewRound();  // Corrigido para startNewRound()

  // Exibindo o placar
  mesa.showScore();

  // Verificando a vitória
  if (mesa.checkVictory()) {
    print('Jogo finalizado! Equipe vencedora: ${mesa.currentRoundWinner == 0 ? mesa.team1.name : mesa.team2.name}');
  }
}
