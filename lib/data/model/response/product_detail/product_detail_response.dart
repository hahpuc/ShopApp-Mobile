import '../base/base_response.dart';

class ProductDetailResponse
    extends BaseResponseData<ProductDetailResponseData> {
  @override
  ProductDetailResponseData parseData(dynamic mapData) {
    return ProductDetailResponseData.fromJson(mapData);
  }
}

class ProductDetailResponseData {
  int? code;
  String? message;
  ProductDetailModel? data;

  ProductDetailResponseData({
    this.code,
    this.message,
    this.data,
  });

  ProductDetailResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null
        ? new ProductDetailModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProductDetailModel {
  String? id;
  String? name;
  CategoryModel? categoryId;
  String? description;
  int? price;
  List<ImageModel>? images;
  int? sold;
  int? quantity;
  int? ratingStar;
  int? reviews;

  ProductDetailModel({
    this.id,
    this.name,
    this.categoryId,
    this.description,
    this.price,
    this.images,
    this.sold,
    this.quantity,
    this.ratingStar,
    this.reviews,
  });

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    categoryId = json['categoryId'] != null
        ? CategoryModel.fromJson(json['categoryId'])
        : null;
    description = json['description'];
    price = json['price'];

    if (json['images'] != null) {
      images = [];
      json['images'].forEach((e) {
        images?.add(new ImageModel.fromJson(e));
      });
    }

    sold = json['sold'];
    quantity = json['quantity'];
    ratingStar = json['rating_star'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['_id'] = this.id;
    map['name'] = this.name;
    if (this.categoryId != null) {
      map['categoryId'] = this.categoryId!.toJson();
    }
    map['description'] = this.description;
    map['price'] = this.price;
    if (this.images != null) {
      map['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    map['sold'] = this.sold;
    map['quantity'] = this.quantity;
    map['rating_star'] = this.ratingStar;
    map['reviews'] = this.reviews;
    return map;
  }

  Map<String, dynamic> toAddProductJson(int number) {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['productId'] = this.id;
    map['quanlity'] = '$number';
    return map;
  }

  Map<String, dynamic> toDeleteProductJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['productId'] = this.id;
    return map;
  }
}

class CategoryModel {
  String? id;
  String? name;

  CategoryModel({
    this.id,
    this.name,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();

    map['_id'] = this.id;
    map['name'] = this.name;

    return map;
  }
}

class ImageModel {
  String? id;
  String? imageUrl;
  String? cloudinaryId;

  ImageModel({
    this.id,
    this.imageUrl,
    this.cloudinaryId,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    imageUrl = json['imageUrl'];
    cloudinaryId = json['cloudinaryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();

    map['_id'] = this.id;
    map['imageUrl'] = this.imageUrl;
    map['cloudinaryId'] = this.cloudinaryId;

    return map;
  }
}
