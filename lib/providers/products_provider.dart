part of 'providers.dart';

class ProductProvider {
  int _removed = 0;
  int _returned = 0;

  Future<bool> retrieveHasMoreReached() async {
    return _returned + _removed == _ProductGenerator.generateRandomProductsLength;
  }

  Future<ProductModel?> create() async {
    if (_removed > 0) {
      _removed -= 1;
    }

    if (_returned + _removed + 1 > _ProductGenerator.generateRandomProductsLength) {
      return null;
    }

    _returned += 1;

    return _ProductGenerator.generateRandomProduct();
  }

  Future<List<ProductModel>> findPart({int skip = 0, int limit = 30}) async {
    await _networkDelay();

    final resultLength = _calcResultLength(_returned, limit);
    _returned += resultLength;

    return [
      for (var i = 0; i < resultLength; i++) _ProductGenerator.generateRandomProduct(),
    ];
  }

  Future<List<ProductModel>> findAll() async {
    final resultLength = _calcResultLength(
      _returned,
      _ProductGenerator.generateRandomProductsLength,
    );

    if (resultLength == 0) {
      return [];
    }

    final completer = Completer<List<ProductModel>>();

    if (!Computer().isRunning) {
      await Computer().turnOn(workersCount: 1);
    }

    Computer().compute(generateList, param: resultLength).then((result) async {
      await Computer().turnOff();

      _returned += resultLength;
      completer.complete(result);
    }).catchError((error) async {
      await Computer().turnOff();
      completer.completeError(error);
    });

    return completer.future;
  }

  Future<List<ProductModel>> generateList(int amount) async {
    return [
      for (var i = 0; i < amount; i++) _ProductGenerator.generateRandomProduct(),
    ];
  }

  Future<void> removeById(IdModel id) async {
    if (_returned - 1 >= 0) {
      _returned -= 1;
      _removed += 1;
    }
  }

  int _calcResultLength(int skip, int limit) {
    if (_ProductGenerator.generateRandomProductsLength - _removed <= skip) {
      return 0;
    }

    final diff = _ProductGenerator.generateRandomProductsLength - _removed - (skip + limit);

    if (diff > 0) {
      if (diff >= limit) {
        return limit;
      }

      return diff;
    }

    if (diff < 0) {
      if (diff.abs() >= limit) {
        return 0;
      }

      return limit - diff.abs();
    }

    return limit;
  }
}

abstract class _ProductGenerator {
  static int? _productsLength;
  static int get generateRandomProductsLength {
    return _productsLength ??= math.Random().nextInt(2) == 1 ? 1000 : 10000;
  }

  static ProductModel generateRandomProduct() {
    final randomTitleUrlEntry = dictionary.entries.elementAt(
      math.Random().nextInt(dictionary.length),
    );

    return ProductModel(
      id: IdModel.generateFromRandomUUID(),
      imageUrl: randomTitleUrlEntry.value,
      title: randomTitleUrlEntry.key,
    );
  }

  static const dictionary = <String, String>{
    'Coca-Cola': 'https://raw.githubusercontent.com/dmitriismitnov/test2/master/cola.png',
    'Fanta': 'https://raw.githubusercontent.com/dmitriismitnov/test2/master/fanta.png',
    'Sprite': 'https://raw.githubusercontent.com/dmitriismitnov/test2/master/sprite.png',
    'Lipton Ice Tea': 'https://raw.githubusercontent.com/dmitriismitnov/test2/master/lipton.png',
    'Rich Apple': 'https://raw.githubusercontent.com/dmitriismitnov/test2/master/rich_apple.png',
    'Rich Grapefruit': 'https://raw.githubusercontent.com/dmitriismitnov/test2/master/rich_grapefruit.png',
    'Mirinda': 'https://raw.githubusercontent.com/dmitriismitnov/test2/master/mirinda.png',
    '7 UP': 'https://raw.githubusercontent.com/dmitriismitnov/test2/master/seven_up.png',
    'Pepsi': 'https://raw.githubusercontent.com/dmitriismitnov/test2/master/pepsi.png',
  };
}
