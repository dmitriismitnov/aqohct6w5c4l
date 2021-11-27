import 'package:aqohct6w5c4l/models/models.dart';
import 'package:aqohct6w5c4l/providers/providers.dart';
import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_bloc.freezed.dart';
part 'products_bloc_event.dart';
part 'products_bloc_state.dart';

class ProductsBloc extends Bloc<ProductsBlocEvent, ProductsBlocState> {
  final ProductProvider _productProvider;

  ProductsBloc({
    required ProductProvider productProvider,
    ProductsBlocState initialState = const ProductsBlocState.initial(),
  })  : _productProvider = productProvider,
        super(initialState) {
    on<ProductsBlocEventLoadPart>(_loadPart);
    on<ProductsBlocEventAddOneRandom>(_addOneRandom);
    on<ProductsBlocEventRemoveOneById>(_removeOneById);
  }

  var _productsStore = BuiltList<ProductModel>();

  Future<void> _loadPart(ProductsBlocEventLoadPart event, Emitter<ProductsBlocState> emit) async {
    emit(ProductsBlocState.pending(products: _productsStore.toList()));

    final productsBatch = await _productProvider.load(limit: 30);
    final productStoreBuilder = _productsStore.toBuilder()
      ..addAll(
        productsBatch,
      );

    _productsStore = productStoreBuilder.build();

    emit(ProductsBlocState.succeeded(products: _productsStore.toList()));
  }

  Future<void> _removeOneById(ProductsBlocEventRemoveOneById event, Emitter<ProductsBlocState> emit) async {
    emit(ProductsBlocState.pending(products: _productsStore.toList()));

    final productStoreBuilder = _productsStore.toBuilder()
      ..removeWhere(
        (product) => product.id == event.id,
      );

    _productsStore = productStoreBuilder.build();

    emit(ProductsBlocState.succeeded(products: _productsStore.toList()));
  }

  Future<void> _addOneRandom(ProductsBlocEventAddOneRandom event, Emitter<ProductsBlocState> emit) async {
    emit(ProductsBlocState.pending(products: _productsStore.toList()));

    final createdProduct = await _productProvider.create();
    final productStoreBuilder = _productsStore.toBuilder()..insert(0, createdProduct);

    _productsStore = productStoreBuilder.build();

    emit(ProductsBlocState.succeeded(products: _productsStore.toList()));
  }
}
