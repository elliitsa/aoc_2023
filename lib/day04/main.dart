import 'dart:io';
import 'dart:math';

void main() {
  var input = File('lib/day04/input.txt').readAsLinesSync();

  part1(input);
}

void part1(List<String> input) {
  var listOfCards = <Card>[];
  for (int i = 0; i < input.length; i++) {
    var card = input[i].split(': ');
    var winningNumbers = card.last
        .split(' | ')
        .first
        .split(' ')
        .where((element) => element.isNotEmpty)
        .map(int.parse)
        .toList();
    var myNumbers = card.last
        .split(' | ')
        .last
        .split(' ')
        .where((element) => element.isNotEmpty)
        .map(int.parse)
        .toList();
    listOfCards.add(
      Card(
        id: int.parse(card.first.replaceAll(RegExp('[^0-9]'), '')),
        winningNumbers: winningNumbers,
        myNumbers: myNumbers,
      ),
    );
  }
  getPoints(listOfCards);
  part2(listOfCards);
}

class Card {
  Card({
    required this.id,
    required this.winningNumbers,
    required this.myNumbers,
    this.occurrences = 1,
  });

  final int id;
  final List<int> winningNumbers;
  final List<int> myNumbers;
  late int occurrences;
}

void part2(List<Card> cards) {
  var count = 1;
  for (int i = 0; i < cards.length; i++) {
    var list = getMatches(cards[i].winningNumbers, cards[i].myNumbers);
    print('list ${i + 1}: $list');
    print('length: ${list.length}');
      for (int j = 0; j < list.length; j++) {
        cards[i + j + 1].occurrences += cards[i].occurrences;
      }
  }
  for (int i = 0; i < cards.length; i++) {
    if (i != 0) {
      print('card id: ${cards[i].id} has ${cards[i].occurrences} occurrences');
      count += cards[i].occurrences;
    } else {
      print('card id: ${cards[i].id} with ${cards[i].occurrences} occurrences');
    }
  }
  print(count);
}

void getPoints(List<Card> cards) {
  int sum = 0;
  for (Card card in cards) {
    var list = getMatches(card.winningNumbers, card.myNumbers);
    if (list.isEmpty) {
      sum += 0;
    } else if (list.length == 1) {
      sum += 1;
    } else if (list.length == 12) {
      sum += 2;
    } else {
      sum += pow(2, list.length - 1).toInt();
    }
  }
  print(sum);
}

List<int?> getMatches(List<int> winningNumbers, List<int> myNumbers) {
  var list = <int>[];
  for (int number in myNumbers) {
    if (winningNumbers.contains(number)) {
      list.add(number);
    }
  }
  return list;
}
