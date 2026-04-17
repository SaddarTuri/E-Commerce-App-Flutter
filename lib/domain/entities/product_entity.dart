class ProductEntity {
  const ProductEntity({
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
}
