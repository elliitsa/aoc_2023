import 'dart:io';

void main() {
  var input = File('lib/day02/input.txt').readAsLinesSync();
  part1(input);
}

void part1(List<String> input) {
  List<Game> games = [];
  var splitter = input.map((game) => game.split(':')).toList();
  int sum = 0;
  int powerSum = 0;
  for (int i = 0; i < splitter.length; i++) {
    var sections = splitter[i].last.split(';');
    games.add(Game(
      id: splitter[i].first.replaceAll(RegExp('[^0-9]'), ''),
      cubes: getListOfValidMapsOrNull(sections).$2.$1 == 0
          ? getListOfValidMapsOrNull(sections).$1
          : null,
    ));
    powerSum += getListOfValidMapsOrNull(sections).$2.$2!;
  }
  for (int i = 0; i < games.length; i++) {
    if (games[i].cubes != null) {
      sum += int.parse(games[i].id);
    }
  }
  print(sum);
  print(powerSum);
}

(List<Map<String, int?>>, (int, int?)) getListOfValidMapsOrNull(
    List<String> sections) {
  Map<String, int?> mapSub = {
    'red': 0,
    'green': 0,
    'blue': 0,
  };
  Map<String, int?> mapMaxCubes = {
    'red': 0,
    'green': 0,
    'blue': 0,
  };
  var listOfMaps = <Map<String, int?>>[];
  var amountInvalid = 0;
  for (var section in sections) {
    var splitSection = section.split(',');
    var redAmount = splitSection
        .where((cube) => cube.trimLeft().split(' ').last == 'red')
        .firstOrNull
        ?.replaceAll(RegExp('[^0-9]'), '');
    var greenAmount = splitSection
        .where((cube) => cube.trimLeft().split(' ').last == 'green')
        .firstOrNull
        ?.replaceAll(RegExp('[^0-9]'), '');
    var blueAmount = splitSection
        .where((cube) => cube.trimLeft().split(' ').last == 'blue')
        .firstOrNull
        ?.replaceAll(RegExp('[^0-9]'), '');
    mapSub.update('red',
        (value) => value = redAmount != null ? int.parse(redAmount) : null);
    if (mapMaxCubes['red'] != null && redAmount != null) {
      mapMaxCubes.update(
          'red',
          (value) => value! < int.parse(redAmount)
              ? value = int.parse(redAmount)
              : value);
    }
    mapSub.update('green',
        (value) => value = greenAmount != null ? int.parse(greenAmount) : null);
    if (mapMaxCubes['green'] != null && greenAmount != null) {
      mapMaxCubes.update(
          'green',
          (value) => value! < int.parse(greenAmount)
              ? value = int.parse(greenAmount)
              : value);
    }
    mapSub.update('blue',
        (value) => value = blueAmount != null ? int.parse(blueAmount) : null);
    if (mapMaxCubes['blue'] != null && blueAmount != null) {
      mapMaxCubes.update(
          'blue',
          (value) => value! < int.parse(blueAmount)
              ? value = int.parse(blueAmount)
              : value);
    }
    if (checkMapIfValid(mapSub)) {
      listOfMaps.add(Map.from(mapSub));
    } else {
      amountInvalid++;
    }
  }
  var power = 0;
  if (mapMaxCubes['red'] == 0) {
    power = (mapMaxCubes['green'] ?? 1) * (mapMaxCubes['blue'] ?? 1);
  } else if (mapMaxCubes['green'] == 0) {
    power = (mapMaxCubes['red'] ?? 1) * (mapMaxCubes['blue'] ?? 1);
  } else if (mapMaxCubes['blue'] == 0) {
    power = (mapMaxCubes['red'] ?? 1) * (mapMaxCubes['green'] ?? 1);
  } else if (mapMaxCubes['red'] == 0 && mapMaxCubes['green'] == 0) {
    power = (mapMaxCubes['blue'] ?? 0);
  } else if (mapMaxCubes['red'] == 0 && mapMaxCubes['blue'] == 0) {
    power = (mapMaxCubes['green'] ?? 0);
  } else if (mapMaxCubes['green'] == 0 && mapMaxCubes['blue'] == 0) {
    power = (mapMaxCubes['red'] ?? 0);
  } else {
    power = (mapMaxCubes['red'] ?? 1) *
        (mapMaxCubes['green'] ?? 1) *
        (mapMaxCubes['blue'] ?? 1);
  }
  return (listOfMaps, (amountInvalid, power));
}

bool checkMapIfValid(Map<String, int?> map) {
  bool isRedValid = false;
  bool isGreenValid = false;
  bool isBlueValid = false;
  if ((map.containsKey('red') &&
          map['red'] != null &&
          map['red']! <= bag['red']!) ||
      map['red'] == null) {
    isRedValid = true;
  }
  if (map.containsKey('green') &&
          map['green'] != null &&
          map['green']! <= bag['green']! ||
      map['green'] == null) {
    isGreenValid = true;
  }
  if (map.containsKey('blue') &&
          map['blue'] != null &&
          map['blue']! <= bag['blue']! ||
      map['blue'] == null) {
    isBlueValid = true;
  }
  return isRedValid && isGreenValid && isBlueValid;
}

Map<String, int> bag = {
  'red': 12,
  'green': 13,
  'blue': 14,
};

class Game {
  const Game({
    required this.id,
    required this.cubes,
  });

  final String id;
  final List<Map<String, int?>>? cubes;
}
