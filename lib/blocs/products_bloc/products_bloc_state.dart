part of 'products_bloc.dart';

@freezed
class ProductsBlocState with _$ProductsBlocState {
  const ProductsBlocState._();

  const factory ProductsBlocState.initial({
    @Default([]) List<ProductModel>? products,
    @Default(false) bool? hasMoreReached,
  }) = ProductsBlocStateInitial;

  const factory ProductsBlocState.pending({
    @Default([]) List<ProductModel>? products,
    @Default(false) bool? hasMoreReached,
  }) = ProductsBlocStatePending;

  const factory ProductsBlocState.succeeded({
    @Default([]) List<ProductModel>? products,
    @Default(false) bool? hasMoreReached,
  }) = ProductsBlocStateSucceeded;

  const factory ProductsBlocState.failed({
    required String message,
    @Default([]) List<ProductModel>? products,
    @Default(false) bool? hasMoreReached,
  }) = ProductsBlocStateFailed;

  bool get isInitialState => this is ProductsBlocStateInitial;
  bool get isPendingState => this is ProductsBlocStatePending;
  bool get isSucceededState => this is ProductsBlocStateSucceeded;
  bool get isFailedState => this is ProductsBlocStateFailed;

  ProductsBlocStateInitial? get tryAsInitialState => isInitialState ? asInitialState : null;
  ProductsBlocStatePending? get tryAsPendingState => isPendingState ? asPendingState : null;
  ProductsBlocStateSucceeded? get tryAsSucceededState => isSucceededState ? asSucceededState : null;
  ProductsBlocStateFailed? get tryAsFailedState => isFailedState ? asFailedState : null;

  ProductsBlocStateInitial get asInitialState => this as ProductsBlocStateInitial;
  ProductsBlocStatePending get asPendingState => this as ProductsBlocStatePending;
  ProductsBlocStateSucceeded get asSucceededState => this as ProductsBlocStateSucceeded;
  ProductsBlocStateFailed get asFailedState => this as ProductsBlocStateFailed;

  String get unsafeFailedMessage => maybeFailedMessage!;
  String? get maybeFailedMessage => tryAsFailedState?.message;

  List<ProductModel> get unsafeProducts => maybeProducts!;
  List<ProductModel>? get maybeProducts => products;

  bool get unsafeHasMoreReached => maybeHasMoreReached!;
  bool? get maybeHasMoreReached =>
      tryAsInitialState?.hasMoreReached ??
      tryAsPendingState?.hasMoreReached ??
      tryAsSucceededState?.hasMoreReached ??
      tryAsFailedState?.hasMoreReached;
}
