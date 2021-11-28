import 'package:aqohct6w5c4l/blocs/products_bloc/products_bloc.dart';
import 'package:aqohct6w5c4l/providers/providers.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const maxLimit = 50;
  ProductsProvider? productProvider;
  ProductsBloc? productsBloc;

  setUp(() {
    productProvider = ProductsProvider(
      maxLimit: maxLimit,
    );

    productsBloc = ProductsBloc(
      productProvider: productProvider!,
    );
  });

  test('Check initial state', () {
    expect(productsBloc?.state, equals(const ProductsBlocState.initial()));
  });

  blocTest(
    'ProductsBlocEvent.loadPart',
    setUp: () {
      productProvider = ProductsProvider(
        maxLimit: maxLimit,
      );
    },
    build: () {
      return ProductsBloc(productProvider: productProvider!);
    },
    act: (ProductsBloc bloc) {
      bloc.add(const ProductsBlocEvent.loadPart());
    },
    expect: () => [
      isA<ProductsBlocStatePending>(),
      isA<ProductsBlocStateSucceeded>(),
    ],
  );

  blocTest(
    'ProductsBlocEvent.loadPart',
    setUp: () {
      productProvider = ProductsProvider(
        maxLimit: maxLimit,
      );
    },
    build: () {
      return ProductsBloc(productProvider: productProvider!);
    },
    act: (ProductsBloc bloc) {
      bloc.add(const ProductsBlocEvent.loadPart());
    },
    expect: () => [
      isA<ProductsBlocStatePending>(),
      isA<ProductsBlocStateSucceeded>(),
    ],
  );

  blocTest(
    'ProductsBlocEvent.addOneRandom',
    setUp: () {
      productProvider = ProductsProvider(
        maxLimit: maxLimit,
      );
    },
    build: () {
      return ProductsBloc(productProvider: productProvider!);
    },
    act: (ProductsBloc bloc) {
      bloc.add(const ProductsBlocEvent.addOneRandom());
    },
    expect: () => [
      isA<ProductsBlocStatePending>(),
      isA<ProductsBlocStateSucceeded>(),
    ],
  );
}
