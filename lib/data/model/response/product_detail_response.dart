import 'base/base_response.dart';

class ProductDetailResponse
    extends BaseResponseData<ProductDetailResponseData> {}

class ProductDetailResponseData {
  final int? categoriesID;
  final String? name;
  final String? description;
  final double? price;
  final double? ratingStar;
  final int? reviews;
  final List<String>? images;

  ProductDetailResponseData({
    this.categoriesID,
    this.name,
    this.description,
    this.price,
    this.ratingStar,
    this.reviews,
    this.images = const [],
  });
}
