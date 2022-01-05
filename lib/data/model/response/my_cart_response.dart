import 'package:furniture_shop/data/model/response/base/base_response.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';

class MyCartResponse extends BaseResponseData<MyCartResponseData> {
  @override
  MyCartResponseData parseData(data) {
    return MyCartResponseData.fromJson(data);
  }
}

class MyCartResponseData {
  int? code;
  String? message;
  MyCartResponseModel? data;

  MyCartResponseData({
    this.code,
    this.message,
    this.data,
  });

  MyCartResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null
        ? new MyCartResponseModel.fromJson(json['data'])
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

class MyCartResponseModel {
  String? id;
  List<ProductModel>? products;

  MyCartResponseModel({this.products, this.id});

  MyCartResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((e) {
        products?.add(new ProductModel.fromJson(e));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    if (this.products != null) {
      map['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    map['_id'] = this.id;
    return map;
  }
}

class ProductModel {
  String? id;
  int? quantity;
  ProductIdModel? productId;

  ProductModel({this.id, this.quantity, this.productId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    quantity = json['quantity'];
    productId = ProductIdModel.fromJson(json['productId']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['_id'] = this.id;
    map['quanlity'] = this.quantity;
    map['productId'] = this.productId;
    return map;
  }

  Map<String, dynamic> toRequestOrder() {
    final Map<String, dynamic> map = new Map<String, dynamic>();

    map['productId'] = this.productId!.id;
    map['quantity'] = this.quantity;

    return map;
  }
}

class ProductIdModel {
  int? sold;
  int? quantity;
  int? ratingStar;
  int? reviews;
  String? id;
  String? name;
  String? categoryId;
  int? price;
  String? description;
  List<ImageModel>? images;

  ProductIdModel(
      {this.id,
      this.quantity,
      this.sold,
      this.categoryId,
      this.description,
      this.images,
      this.name,
      this.price,
      this.ratingStar,
      this.reviews});

  ProductIdModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    ratingStar = json['rating_star'];
    quantity = json['quantity'];
    sold = json['sold'];
    reviews = json['reviews'];
    name = json['name'];
    categoryId = json['categoryId'];
    price = json['price'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((e) {
        images?.add(new ImageModel.fromJson(e));
      });
    }
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['_id'] = this.id;
    map['rating_Star'] = this.ratingStar;
    map['sold'] = this.sold;
    map['reviews'] = this.reviews;
    map['quantity'] = this.quantity;
    map['name'] = this.name;
    map['categoryId'] = this.categoryId;
    map['price'] = this.price;
    if (this.images != null) {
      map['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    map['description'] = this.description;
    return map;
  }
}
