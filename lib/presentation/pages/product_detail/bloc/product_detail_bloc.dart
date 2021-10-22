import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/product_detail_response.dart';
import 'package:furniture_shop/presentation/pages/product_detail/bloc/product_detail_state.dart';

class ProductDetailPageBloc extends BaseBloc<ProductDetailPageState> {
  final AppRepository appRepository;
  ProductDetailPageBloc({required this.appRepository})
      : super(ProductDetailPageState());

  Future<void> getProductDetailsData(String productID) async {
    emit(ProductDetailPageLoadingState());
    await Future.delayed(Duration(seconds: 1));

    List<String> images = [
      'http://res.cloudinary.com/dynk5q1io/image/upload/v1634120352/products/Gaming%20Table/axmlvoybwtp7xekzz6eq.jpg',
      'http://res.cloudinary.com/dynk5q1io/image/upload/v1634120354/products/Gaming%20Table/z36qyy9awic0eltow6qi.jpg',
      'http://res.cloudinary.com/dynk5q1io/image/upload/v1634120357/products/Gaming%20Table/g9xxtp6mtfdmh00kosmt.jpg',
    ];

    ProductDetailResponseData data = ProductDetailResponseData(
      name: 'Gaming Table',
      description:
          'Gaming Table is made of by natural wood.The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. ',
      price: 349.99,
      ratingStar: 4.5,
      reviews: 233,
      images: images,
    );

    emit(ProductDetailPageGetDataSuccessState(data));
  }
}
