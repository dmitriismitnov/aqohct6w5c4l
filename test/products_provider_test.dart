// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:aqohct6w5c4l/models/models.dart';
import 'package:aqohct6w5c4l/providers/providers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const maxLimit = 50;
  ProductsProvider? productsProvider;

  setUp(() {
    productsProvider = ProductsProvider(
      maxLimit: maxLimit,
    );
  });

  test('.findPart (check limit)', () async {
    const limit = 10;

    final foundProductsList = await productsProvider?.findPart(limit: limit);

    expect(foundProductsList, isA<List<ProductModel>>());
    expect(foundProductsList?.length, limit);
  });

  test('.findPart (check part by part)', () async {
    const limit = 10;
    int totalLengthOfProducts = 0;

    while (true) {
      final foundProductsList = await productsProvider?.findPart(limit: limit);

      expect(foundProductsList, isA<List<ProductModel>>());

      if (foundProductsList!.isEmpty) {
        expect(totalLengthOfProducts, maxLimit);
        break;
      }

      totalLengthOfProducts += foundProductsList.length;
    }
  });

  test('.findAll (straightforward)', () async {
    final foundProductsList = await productsProvider?.findAll();

    expect(foundProductsList, isA<List<ProductModel>>());
    expect(foundProductsList?.length, maxLimit);
  });

  test('.create (straightforward)', () async {
    final createdProduct = await productsProvider?.create();

    expect(createdProduct, isA<ProductModel>());
    expect(createdProduct?.id, isA<IdModel>());
    expect(createdProduct?.imageUrl, isA<String>());
    expect(createdProduct?.title, isA<String>());
  });

  test('.removeById (straightforward)', () async {
    final createdProduct = await productsProvider?.create();
    await productsProvider?.removeById(createdProduct!.id);

    final foundProductsList = await productsProvider?.findAll();
    expect(foundProductsList?.length, maxLimit - 1);
  });

  test('.create (after find all)', () async {
    await productsProvider?.findAll();
    final createdProduct = await productsProvider?.create();

    expect(createdProduct, isNull);
  });

  test('.create (recovery after remove)', () async {
    final createdProduct = await productsProvider?.create();
    await productsProvider?.removeById(createdProduct!.id);

    final foundProductsList = await productsProvider?.findAll();
    expect(foundProductsList?.length, maxLimit - 1);

    final recoveredProduct = await productsProvider?.create();
    expect(recoveredProduct, isA<ProductModel>());

    final productOverLimit = await productsProvider?.create();
    expect(productOverLimit, isNull);
  });
}
