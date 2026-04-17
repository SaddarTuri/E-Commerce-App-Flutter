import '../../domain/entities/product_entity.dart';

class ProductModel {
  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category,
  });

  final int id;
  final String title;
  final double price;
  final String image;
  final String category;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] as String?) ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      image: (json['image'] as String?) ?? '',
      category: (json['category'] as String?) ?? '',
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      price: price,
      image: image,
      category: category,
    );
  }
}
