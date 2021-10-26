import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/my_cart_response.dart';
import 'package:furniture_shop/presentation/pages/cart/bloc/my_cart_page_state.dart';

class MyCartPageBloc extends BaseBloc<MyCartPageState> {
  final AppRepository appRepository;
  MyCartPageBloc({required this.appRepository}) : super(MyCartPageState());

  Future<void> getMyCart() async {
    emit(MyCartPageLoadingState());
    await Future.delayed(Duration(seconds: 1));

    List<MyCartResponseData> data = [
      MyCartResponseData(
          urlImage:
              'http://res.cloudinary.com/dynk5q1io/image/upload/v1634120352/products/Gaming%20Table/axmlvoybwtp7xekzz6eq.jpg',
          productName: 'Morden Lamp',
          price: 50.00,
          total: 1),
      MyCartResponseData(
          urlImage:
              'http://res.cloudinary.com/dynk5q1io/image/upload/v1634120357/products/Gaming%20Table/g9xxtp6mtfdmh00kosmt.jpg',
          productName: 'Coffee Chair',
          price: 20.00,
          total: 2),
    ];

    emit(MyCartPageGetDataSuccessState(data));
  }
}
