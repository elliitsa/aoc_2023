import 'dart:io';

void main() {
  var input = File('lib/day03/input.txt').readAsLinesSync();

  input.add('.' * input.length);
  var t = input.reversed.toList();
  t.add('.' * (input.length-1));
  input = t.reversed.toList();
  var temp = input.map((s) => '.$s.').toList();
  input = temp;
  input.add('.' * input.length);
  var t1 = input.reversed.toList();
  t1.add('.' * (input.length-1));
  input = t1.reversed.toList();
  var temp1 = input.map((s) => '.$s.').toList();
  input = temp1;

  part1(input);
}

void part1(List<String> input) {
  var str = '';
  for (int i = 0; i < input.length; i++) {
    print(input[i]);
    for (int j = 0; j < input[i].length; j++) {
      if (isNumeric(input[i][j])) {
        // get 3 symbols
        var temp = '';
        temp += input[i][j];
        temp += input[i][j + 1];
        temp += input[i][j + 2];
        // check if it is 3 digit
        if (isNumeric(temp[2]) && isNumeric(temp[1]) && isNumeric(temp[0])) {
          // check if it is adjacent to a special sign
          if (isSpecialChar(input[i][j - 1]) ||
              isSpecialChar(input[i + 1][j - 1]) ||
              isSpecialChar(input[i - 1][j - 1]) ||
              isSpecialChar(input[i + 1][j]) ||
              isSpecialChar(input[i - 1][j]) ||
              isSpecialChar(input[i - 1][j + 1]) ||
              isSpecialChar(input[i + 1][j + 1]) ||
              isSpecialChar(input[i - 1][j + 2]) ||
              isSpecialChar(input[i + 1][j + 2]) ||
              isSpecialChar(input[i - 1][j + 3]) ||
              isSpecialChar(input[i + 1][j + 3]) ||
              isSpecialChar(input[i][j + 3])) {
            str += temp;
            str += ' ';
            j += 3;
          }
        }
        // check if it is 2 digit
        else if (!isNumeric(temp[2]) && isNumeric(temp[1])) {
          // check if it is adjacent to a special sign
          if (isSpecialChar(input[i][j - 1]) ||
              isSpecialChar(input[i + 1][j - 1]) ||
              isSpecialChar(input[i - 1][j - 1]) ||
              isSpecialChar(input[i + 1][j]) ||
              isSpecialChar(input[i - 1][j]) ||
              isSpecialChar(input[i - 1][j + 1]) ||
              isSpecialChar(input[i + 1][j + 1]) ||
              isSpecialChar(input[i - 1][j + 2]) ||
              isSpecialChar(input[i + 1][j + 2]) ||
              isSpecialChar(input[i][j + 2])) {
            str += temp.substring(0, temp.length - 1);
            str += ' ';
            j += 2;
          }
        }
        // check if it is 1 digit
        else if (!isNumeric(temp[1]) && isNumeric(temp[0])) {
          // check if it is adjacent to a special sign
          if (isSpecialChar(input[i][j - 1]) ||
              isSpecialChar(input[i + 1][j - 1]) ||
              isSpecialChar(input[i - 1][j - 1]) ||
              isSpecialChar(input[i + 1][j]) ||
              isSpecialChar(input[i - 1][j]) ||
              isSpecialChar(input[i - 1][j + 1]) ||
              isSpecialChar(input[i + 1][j + 1]) ||
              isSpecialChar(input[i][j + 1])) {
            str += temp.substring(0, 1);
            str += ' ';
            j++;
          }
        }
      }
    }
  }
  var sum = str
      .split(' ')
      .map((s) => int.tryParse(s) ?? 0)
      .toList()
      .reduce((a, b) => a + b);
  print(sum);
}

bool isSpecialChar(String s) {
  if (!isNumeric(s) && s != '.') {
    return true;
  } else {
    return false;
  }
}

bool isNumeric(String s) {
  if (int.tryParse(s) != null) {
    return true;
  } else {
    return false;
  }
}
