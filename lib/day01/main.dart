import 'dart:io';

void main() {
  var input = File('lib/day01/input.txt').readAsLinesSync();
  part1(input);
  part2(input);
}

void part1(List<String> input) {
  int sum = 0;
  for (int i = 0; i < input.length; i++) {
    final number = input[i].replaceAll(RegExp('[^0-9]'), '');
    if (number.length == 1) {
      final newNumber = int.parse(number) * 11;
      sum += newNumber;
    } else {
      final newNumber =
          int.parse(number[0]) * 10 + int.parse(number[number.length - 1]);
      sum += newNumber;
    }
  }
  print(sum);
}

String getNumbersFromString(String string) {
  String numberInString = '';
  String charsToCheckIfNumber = '';
  for (int i = 0; i < string.length; i++) {
    // read char by char
    final currentChar = string[i];

    // check if `currentChar` is a digit on its own
    if (RegExp(r'[0-9]').hasMatch(currentChar)) {
      numberInString += currentChar;
      charsToCheckIfNumber = '';
    } else {
      // keep adding chars to `charsToCheckIfNumber`
      charsToCheckIfNumber += currentChar;
      // check if `charsToCheckIfNumber` is an actual number
      // if a number, add to `numberInString` and clean var.
      for (int j = 0; j < charsToCheckIfNumber.length; j++) {
        String substring =
            charsToCheckIfNumber.substring(j, charsToCheckIfNumber.length);

        if (map.containsKey(substring)) {
          final key = map.keys.where((element) => element == substring).first;
          numberInString += map[key].toString();
          charsToCheckIfNumber =
              charsToCheckIfNumber.substring(charsToCheckIfNumber.length - 1);
          substring = '';
        }
      }
    }
  }
  return numberInString;
}

void part2(List<String> input) {
  var list = <String>[];
  for (int i = 0; i < input.length; i++) {
    list.add(getNumbersFromString(input[i]));
  }
  part1(list);
}

Map<String, int> map = {
  'zero': 0,
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9,
};
