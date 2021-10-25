import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/categories_response.dart';
import 'package:furniture_shop/data/model/response/product_detail_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/pages/home/home_state.dart';
import 'package:furniture_shop/data/fake_data.dart';

class HomePageBloc extends BlocBase<HomePageState> {
  final AppRepository appRepository;

  HomePageBloc({required this.appRepository}) : super(HomePageState());

  List<ProductDetailResponseData> listProductResponse = List.of(listProduct);
  List<CategoriesResponseData> listCategories = [
    CategoriesResponseData(
        id: 1, name: "Popular", image: Assets.images.icPopular.path),
    CategoriesResponseData(
        id: 2, name: "Chair", image: Assets.images.icChair.path),
    CategoriesResponseData(
        id: 3, name: "Lamp", image: Assets.images.icLamp.path),
    CategoriesResponseData(
        id: 4, name: "Armchair", image: Assets.images.icArmchair.path),
    CategoriesResponseData(id: 5, name: "TV", image: Assets.images.icTv.path),
    CategoriesResponseData(id: 6, name: "Bed", image: Assets.images.icBed.path)
  ];

  Future<void> getCategoriesData() async {
    emit(HomePageLoadingState());

    if (listCategories != null) {
      emit(HomePageGetDataSuccessState(listCategories));
    } else
      emit(HomePageGetDataFailState());
  }

  List<ProductDetailResponseData>? getProductWithCategoriesID(
      CategoriesResponseData categoriesResponseData) {
    List<ProductDetailResponseData>? listProduct;
    listProductResponse.forEach((element) {
      if (element.categoriesID == categoriesResponseData.id) {
        listProduct?.add(element);
      }
    });
    return listProduct;
  }
}
