part of 'providers.dart';

class ProductProvider {
  Future<ProductModel> create() async {
    return _ProductGenerator.generateRandom();
  }

  Future<List<ProductModel>> load({int limit = 30}) async {
    await _networkDelay();

    return [
      for (var i = 0; i < limit; i++) _ProductGenerator.generateRandom(),
    ];
  }
}

abstract class _ProductGenerator {
  static ProductModel generateRandom() {
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
