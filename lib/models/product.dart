part of './models.dart';

@immutable
class ProductModel with EquatableMixin {
  final IdModel id;
  final String imageUrl;
  final String title;

  ProductModel({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  ProductModel copyWith({
    String? imageUrl,
    String? title,
  }) {
    return ProductModel(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      id: id,
    );
  }

  @override
  List<Object?> get props {
    return [
      imageUrl,
      title,
    ];
  }
}
