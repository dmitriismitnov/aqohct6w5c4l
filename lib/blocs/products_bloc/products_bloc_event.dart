part of 'products_bloc.dart';

@freezed
class ProductsBlocEvent with _$ProductsBlocEvent {
  const factory ProductsBlocEvent.loadPart() = ProductsBlocEventLoadPart;
  const factory ProductsBlocEvent.addOneRandom() = ProductsBlocEventAddOneRandom;
  const factory ProductsBlocEvent.removeOneById(IdModel id) = ProductsBlocEventRemoveOneById;
}
