import 'package:aqohct6w5c4l/models/models.dart';
import 'package:aqohct6w5c4l/providers/providers.dart';
import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_bloc.freezed.dart';
part 'products_bloc_event.dart';
part 'products_bloc_state.dart';

class ProductsBloc extends Bloc<ProductsBlocEvent, ProductsBlocState> {
  final ProductsProvider _productProvider;

  ProductsBloc({
    required ProductsProvider productProvider,
    ProductsBlocState initialState = const ProductsBlocState.initial(),
  })  : _productProvider = productProvider,
        super(initialState) {
    on<ProductsBlocEventAddOneRandom>(_addOneRandom);
    on<ProductsBlocEventLoadPart>(_loadPart);
    on<ProductsBlocEventRemoveOneById>(_removeOneById);
  }

  var _productsStore = BuiltList<ProductModel>();

  Future<void> _addOneRandom(ProductsBlocEventAddOneRandom event, Emitter<ProductsBlocState> emit) async {
    emit(
      ProductsBlocState.pending(
        products: state.maybeProducts,
        hasMoreReached: state.hasMoreReached,
      ),
    );

    final createdProduct = await _productProvider.create();

    if (createdProduct != null) {
      final productStoreBuilder = _productsStore.toBuilder()..insert(0, createdProduct);
      _productsStore = productStoreBuilder.build();
    }

    emit(
      ProductsBlocState.succeeded(
        products: _productsStore.toList(),
        hasMoreReached: await _productProvider.retrieveHasMoreReached(),
      ),
    );
  }

  Future<void> _loadPart(ProductsBlocEventLoadPart event, Emitter<ProductsBlocState> emit) async {
    const loadLimit = 30;

    emit(
      ProductsBlocState.pending(
        products: state.maybeProducts,
        hasMoreReached: false,
      ),
    );

    final productsBatch = await _productProvider.findPart(
      skip: _productsStore.length,
      limit: loadLimit,
    );

    if (productsBatch.isNotEmpty) {
      final productStoreBuilder = _productsStore.toBuilder()
        ..addAll(
          productsBatch,
        );

      _productsStore = productStoreBuilder.build();

      return emit(
        ProductsBlocState.succeeded(
          products: _productsStore.toList(),
          hasMoreReached: productsBatch.length != loadLimit,
        ),
      );
    }

    if (productsBatch.isEmpty && state.maybeHasMoreReached != true) {
      return emit(
        ProductsBlocState.succeeded(
          products: _productsStore.toList(),
          hasMoreReached: true,
        ),
      );
    }
  }

  Future<void> _removeOneById(ProductsBlocEventRemoveOneById event, Emitter<ProductsBlocState> emit) async {
    emit(
      ProductsBlocState.pending(
        products: state.maybeProducts,
        hasMoreReached: state.hasMoreReached,
      ),
    );

    await _productProvider.removeById(event.id);

    final productStoreBuilder = _productsStore.toBuilder()
      ..removeWhere(
        (product) => product.id == event.id,
      );

    _productsStore = productStoreBuilder.build();

    emit(
      ProductsBlocState.succeeded(
        products: _productsStore.toList(),
        hasMoreReached: state.maybeHasMoreReached,
      ),
    );
  }
}
