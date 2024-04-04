import 'dart:math';

var deckOfCards = [
  {
    'name': 'As de Espada',
    'image': 'assets/images/as_espada.jpg',
    'value': 8,
    'suit': 'Espada'
  },
  {
    'name': 'Dois de Espada',
    'image': 'assets/images/dois_espada.jpg',
    'value': 9,
    'suit': 'Espada'
  },
  {
    'name': 'Três de Espada',
    'image': 'assets/images/tres_espada.jpg',
    'value': 10,
    'suit': 'Espada'
  },
  {
    'name': 'Quatro de Espada',
    'image': 'assets/images/quatro_espada.jpg',
    'value': 1,
    'suit': 'Espada'
  },
  {
    'name': 'Cinco de Espada',
    'image': 'assets/images/cinco_espada.jpg',
    'value': 2,
    'suit': 'Espada'
  },
  {
    'name': 'Seis de Espada',
    'image': 'assets/images/seis_espada.jpg',
    'value': 3,
    'suit': 'Espada'
  },
  {
    'name': 'Sete de Espada',
    'image': 'assets/images/sete_espada.jpg',
    'value': 4,
    'suit': 'Espada'
  },
  {
    'name': 'Dez de Espada',
    'image': 'assets/images/dez_espada.jpg',
    'value': 5,
    'suit': 'Espada'
  },
  {
    'name': 'Onze de Espada',
    'image': 'assets/images/onze_espada.jpg',
    'value': 6,
    'suit': 'Espada'
  },
  {
    'name': 'Doze de Espada',
    'image': 'assets/images/doze_espada.jpg',
    'value': 7,
    'suit': 'Espada'
  },
  {
    'name': 'As de Mole',
    'image': 'assets/images/as_Mole.jpg',
    'value': 8,
    'suit': 'Mole'
  },
  {
    'name': 'Dois de Mole',
    'image': 'assets/images/dois_Mole.jpg',
    'value': 9,
    'suit': 'Mole'
  },
  {
    'name': 'Três de Mole',
    'image': 'assets/images/tres_Mole.jpg',
    'value': 10,
    'suit': 'Mole'
  },
  {
    'name': 'Quatro de Mole',
    'image': 'assets/images/quatro_Mole.jpg',
    'value': 1,
    'suit': 'Mole'
  },
  {
    'name': 'Cinco de Mole',
    'image': 'assets/images/cinco_Mole.jpg',
    'value': 2,
    'suit': 'Mole'
  },
  {
    'name': 'Seis de Mole',
    'image': 'assets/images/seis_Mole.jpg',
    'value': 3,
    'suit': 'Mole'
  },
  {
    'name': 'Sete de Mole',
    'image': 'assets/images/sete_Mole.jpg',
    'value': 4,
    'suit': 'Mole'
  },
  {
    'name': 'Dez de Mole',
    'image': 'assets/images/dez_Mole.jpg',
    'value': 5,
    'suit': 'Mole'
  },
  {
    'name': 'Onze de Mole',
    'image': 'assets/images/onze_Mole.jpg',
    'value': 6,
    'suit': 'Mole'
  },
  {
    'name': 'Doze de Mole',
    'image': 'assets/images/doze_Mole.jpg',
    'value': 7,
    'suit': 'Mole'
  },
  {
    'name': 'As de Copas',
    'image': 'assets/images/Copas.jpg',
    'value': 8,
    'suit': 'Copas'
  },
  {
    'name': 'Dois de Copas',
    'image': 'assets/images/dois_Copas.jpg',
    'value': 9,
    'suit': 'Copas'
  },
  {
    'name': 'Três de Copas',
    'image': 'assets/images/tres_Copas.jpg',
    'value': 10,
    'suit': 'Copas'
  },
  {
    'name': 'Quatro de Copas',
    'image': 'assets/images/quatro_Copas.jpg',
    'value': 1,
    'suit': 'Copas'
  },
  {
    'name': 'Cinco de Copas',
    'image': 'assets/images/cinco_Copas.jpg',
    'value': 2,
    'suit': 'Copas'
  },
  {
    'name': 'Seis de Copas',
    'image': 'assets/images/seis_Copas.jpg',
    'value': 3,
    'suit': 'Copas'
  },
  {
    'name': 'Sete de Copas',
    'image': 'assets/images/sete_Copas.jpg',
    'value': 4,
    'suit': 'Copas'
  },
  {
    'name': 'Dez de Copas',
    'image': 'assets/images/dez_Copas.jpg',
    'value': 5,
    'suit': 'Copas'
  },
  {
    'name': 'Onze de Copas',
    'image': 'assets/images/onze_Copas.jpg',
    'value': 6,
    'suit': 'Copas'
  },
  {
    'name': 'Doze de Copas',
    'image': 'assets/images/doze_Copas.jpg',
    'value': 7,
    'suit': 'Copas'
  },
  {
    'name': 'As de Paus',
    'image': 'assets/images/as_Mole.jpg',
    'value': 8,
    'suit': 'Paus'
  },
  {
    'name': 'Dois de Paus',
    'image': 'assets/images/dois_Paus.jpg',
    'value': 9,
    'suit': 'Paus'
  },
  {
    'name': 'Três de Paus',
    'image': 'assets/images/tres_Paus.jpg',
    'value': 10,
    'suit': 'Paus'
  },
  {
    'name': 'Quatro de Paus',
    'image': 'assets/images/quatro_Paus.jpg',
    'value': 1,
    'suit': 'Paus'
  },
  {
    'name': 'Cinco de Paus',
    'image': 'assets/images/cinco_Paus.jpg',
    'value': 2,
    'suit': 'Paus'
  },
  {
    'name': 'Seis de Paus',
    'image': 'assets/images/seis_Paus.jpg',
    'value': 3,
    'suit': 'Paus'
  },
  {
    'name': 'Sete de Paus',
    'image': 'assets/images/sete_Paus.jpg',
    'value': 4,
    'suit': 'Paus'
  },
  {
    'name': 'Dez de Paus',
    'image': 'assets/images/dez_Paus.jpg',
    'value': 5,
    'suit': 'Paus'
  },
  {
    'name': 'Onze de Paus',
    'image': 'assets/images/onze_Paus.jpg',
    'value': 6,
    'suit': 'Paus'
  },
  {
    'name': 'Doze de Paus',
    'image': 'assets/images/doze_Paus.jpg',
    'value': 7,
    'suit': 'Paus'
  }
];

// var pausDeck = [
//   {
//     'name': 'As de Paus',
//     'image': 'assets/images/as_Mole.jpg',
//     'value': 1,
//     'suit': 'Mole'
//   },
//   {
//     'name': 'Dois de Paus',
//     'image': 'assets/images/dois_Paus.jpg',
//     'value': 2,
//     'suit': 'Paus'
//   },
//   {
//     'name': 'Três de Paus',
//     'image': 'assets/images/tres_Paus.jpg',
//     'value': 3,
//     'suit': 'Paus'
//   },
//   {
//     'name': 'Quatro de Paus',
//     'image': 'assets/images/quatro_Paus.jpg',
//     'value': 4,
//     'suit': 'Paus'
//   },
//   {
//     'name': 'Cinco de Paus',
//     'image': 'assets/images/cinco_Paus.jpg',
//     'value': 5,
//     'suit': 'Paus'
//   },
//   {
//     'name': 'Seis de Paus',
//     'image': 'assets/images/seis_Paus.jpg',
//     'value': 6,
//     'suit': 'Paus'
//   },
//   {
//     'name': 'Sete de Paus',
//     'image': 'assets/images/sete_Paus.jpg',
//     'value': 7,
//     'suit': 'Paus'
//   },
//   {
//     'name': 'Oito de Paus',
//     'image': 'assets/images/oito_Paus.jpg',
//     'value': 8,
//     'suit': 'Paus'
//   },
//   {
//     'name': 'Nove de Paus',
//     'image': 'assets/images/nove_Paus.jpg',
//     'value': 9,
//     'suit': 'Paus'
//   },
//   {
//     'name': 'Dez de Paus',
//     'image': 'assets/images/dez_Paus.jpg',
//     'value': 10,
//     'suit': 'Paus'
//   },
//   {
//     'name': 'Onze de Paus',
//     'image': 'assets/images/onze_Paus.jpg',
//     'value': 11,
//     'suit': 'Paus'
//   },
//   {
//     'name': 'Doze de Paus',
//     'image': 'assets/images/doze_Paus.jpg',
//     'value': 12,
//     'suit': 'Paus'
//   }
// ];

// var copasDeck = [
//   {
//     'name': 'As de Copas',
//     'image': 'assets/images/Copas.jpg',
//     'value': 1,
//     'suit': 'Copas'
//   },
//   {
//     'name': 'Dois de Copas',
//     'image': 'assets/images/dois_Copas.jpg',
//     'value': 2,
//     'suit': 'Copas'
//   },
//   {
//     'name': 'Três de Copas',
//     'image': 'assets/images/tres_Copas.jpg',
//     'value': 3,
//     'suit': 'Copas'
//   },
//   {
//     'name': 'Quatro de Copas',
//     'image': 'assets/images/quatro_Copas.jpg',
//     'value': 4,
//     'suit': 'Copas'
//   },
//   {
//     'name': 'Cinco de Copas',
//     'image': 'assets/images/cinco_Copas.jpg',
//     'value': 5,
//     'suit': 'Copas'
//   },
//   {
//     'name': 'Seis de Copas',
//     'image': 'assets/images/seis_Copas.jpg',
//     'value': 6,
//     'suit': 'Copas'
//   },
//   {
//     'name': 'Sete de Copas',
//     'image': 'assets/images/sete_Copas.jpg',
//     'value': 7,
//     'suit': 'Copas'
//   },
//   {
//     'name': 'Oito de Copas',
//     'image': 'assets/images/oito_Copas.jpg',
//     'value': 8,
//     'suit': 'Copas'
//   },
//   {
//     'name': 'Nove de Copas',
//     'image': 'assets/images/nove_Copas.jpg',
//     'value': 9,
//     'suit': 'Copas'
//   },
//   {
//     'name': 'Dez de Copas',
//     'image': 'assets/images/dez_Copas.jpg',
//     'value': 10,
//     'suit': 'Copas'
//   },
//   {
//     'name': 'Onze de Copas',
//     'image': 'assets/images/onze_Copas.jpg',
//     'value': 11,
//     'suit': 'Copas'
//   },
//   {
//     'name': 'Doze de Copas',
//     'image': 'assets/images/doze_Copas.jpg',
//     'value': 12,
//     'suit': 'Copas'
//   }
// ];

// var moleDeck = [
//   {
//     'name': 'As de Mole',
//     'image': 'assets/images/as_Mole.jpg',
//     'value': 1,
//     'suit': 'Mole'
//   },
//   {
//     'name': 'Dois de Mole',
//     'image': 'assets/images/dois_Mole.jpg',
//     'value': 2,
//     'suit': 'Mole'
//   },
//   {
//     'name': 'Três de Mole',
//     'image': 'assets/images/tres_Mole.jpg',
//     'value': 3,
//     'suit': 'Mole'
//   },
//   {
//     'name': 'Quatro de Mole',
//     'image': 'assets/images/quatro_Mole.jpg',
//     'value': 4,
//     'suit': 'Mole'
//   },
//   {
//     'name': 'Cinco de Mole',
//     'image': 'assets/images/cinco_Mole.jpg',
//     'value': 5,
//     'suit': 'Mole'
//   },
//   {
//     'name': 'Seis de Mole',
//     'image': 'assets/images/seis_Mole.jpg',
//     'value': 6,
//     'suit': 'Mole'
//   },
//   {
//     'name': 'Sete de Mole',
//     'image': 'assets/images/sete_Mole.jpg',
//     'value': 7,
//     'suit': 'Mole'
//   },
//   {
//     'name': 'Oito de Mole',
//     'image': 'assets/images/oito_Mole.jpg',
//     'value': 8,
//     'suit': 'Mole'
//   },
//   {
//     'name': 'Nove de Mole',
//     'image': 'assets/images/nove_Mole.jpg',
//     'value': 9,
//     'suit': 'Mole'
//   },
//   {
//     'name': 'Dez de Mole',
//     'image': 'assets/images/dez_Mole.jpg',
//     'value': 10,
//     'suit': 'Mole'
//   },
//   {
//     'name': 'Onze de Mole',
//     'image': 'assets/images/onze_Mole.jpg',
//     'value': 11,
//     'suit': 'Mole'
//   },
//   {
//     'name': 'Doze de Mole',
//     'image': 'assets/images/doze_Mole.jpg',
//     'value': 12,
//     'suit': 'Mole'
//   }
// ];

// var espadaDeck = [
//   {
//     'name': 'As de Espada',
//     'image': 'assets/images/as_espada.jpg',
//     'value': 1,
//     'suit': 'Espada'
//   },
//   {
//     'name': 'Dois de Espada',
//     'image': 'assets/images/dois_espada.jpg',
//     'value': 2,
//     'suit': 'Espada'
//   },
//   {
//     'name': 'Três de Espada',
//     'image': 'assets/images/tres_espada.jpg',
//     'value': 3,
//     'suit': 'Espada'
//   },
//   {
//     'name': 'Quatro de Espada',
//     'image': 'assets/images/quatro_espada.jpg',
//     'value': 4,
//     'suit': 'Espada'
//   },
//   {
//     'name': 'Cinco de Espada',
//     'image': 'assets/images/cinco_espada.jpg',
//     'value': 5,
//     'suit': 'Espada'
//   },
//   {
//     'name': 'Seis de Espada',
//     'image': 'assets/images/seis_espada.jpg',
//     'value': 6,
//     'suit': 'Espada'
//   },
//   {
//     'name': 'Sete de Espada',
//     'image': 'assets/images/sete_espada.jpg',
//     'value': 7,
//     'suit': 'Espada'
//   },
//   {
//     'name': 'Oito de Espada',
//     'image': 'assets/images/oito_espada.jpg',
//     'value': 8,
//     'suit': 'Espada'
//   },
//   {
//     'name': 'Nove de Espada',
//     'image': 'assets/images/nove_espada.jpg',
//     'value': 9,
//     'suit': 'Espada'
//   },
//   {
//     'name': 'Dez de Espada',
//     'image': 'assets/images/dez_espada.jpg',
//     'value': 10,
//     'suit': 'Espada'
//   },
//   {
//     'name': 'Onze de Espada',
//     'image': 'assets/images/onze_espada.jpg',
//     'value': 11,
//     'suit': 'Espada'
//   },
//   {
//     'name': 'Doze de Espada',
//     'image': 'assets/images/doze_espada.jpg',
//   }
// ];

// var pausDeck = 4;
// var copas = 3;
// var espada = 2;
// var mole = 1;

// bool suitComparison(cardOne, cardTwo) {

// }

List shuffleCards(List deck, int numbersOfCards) {

  var shuffledDeck = [];
  var randomNumber = Random();

  while (deck.length > 0) {

    var index = randomNumber.nextInt(deck.length);

    shuffledDeck.add(deck[index]);

    deck.removeAt(index);
  }

  return shuffledDeck;
}

List playersDeck(List shuffledDeck, int players) {

  if (players == 2) {

    var firstDeck = [];
    var secondDeck = [];
    var tableCard = {};
    var maxCardsPerPlayers = 3;

    for (var index = 0; index < maxCardsPerPlayers; index++) {
      firstDeck.add(shuffledDeck.removeAt(0));
      secondDeck.add(shuffledDeck.removeAt(0));
    }

    tableCard = shuffledDeck.removeAt(0);
    var valueToFilter = tableCard['value'] + 1;
    print('carta da mesa $tableCard');
    var jokerCards = shuffledDeck.where((card) => card['value'] == valueToFilter).toList();
    print('coringas $jokerCards');
    for (var jokerCard in shuffledDeck) {
      
    } 
    
    for (var index = 0; index < firstDeck.length; index++) {
      

    }

    for (var index = 0; index < secondDeck.length; index++) {

    }

    return [firstDeck, secondDeck];


  }

  if (players == 4) {

    var firstDeck = [];
    var secondDeck = [];
    var thirdDeck = [];
    var fourthDeck = [];
    var jokerCard = {};
    var maxCardsPerPlayers = 3;

    for (var index = 0; index < maxCardsPerPlayers; index++) {
      firstDeck.add(shuffledDeck.removeAt(0));
      secondDeck.add(shuffledDeck.removeAt(0));
      thirdDeck.add(shuffledDeck.removeAt(0));
      fourthDeck.add(shuffledDeck.removeAt(0));
    }

    jokerCard = shuffledDeck.removeAt(0);

    return [firstDeck, secondDeck, thirdDeck, fourthDeck];
  }

  if (players != 2 && players != 4) {
    print('Número de jogadores inválido');
  }

  return [];
}

void main() {
  var shuffledDeckTest = shuffleCards(deckOfCards, 40);
  // print(shuffledDeckTest);
  var playersDeckTest = playersDeck(shuffledDeckTest, 2);
  // print(playersDeckTest);
}
