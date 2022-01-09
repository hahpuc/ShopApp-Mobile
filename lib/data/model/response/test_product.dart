class ProductTest {
  final int? categoriesID;
  final String? name;
  final String? description;
  final double? price;
  final double? ratingStar;
  final int? reviews;
  final List<String>? images;

  ProductTest({
    this.categoriesID,
    this.name,
    this.description,
    this.price,
    this.ratingStar,
    this.reviews,
    this.images = const [],
  });
}
