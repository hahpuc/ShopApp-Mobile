import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/categories_response.dart';
import 'package:furniture_shop/data/model/response/product_detail_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/pages/home/home_state.dart';

class HomePageBloc extends BlocBase<HomePageState> {
  final AppRepository appRepository;

  HomePageBloc({required this.appRepository}) : super(HomePageState());

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
  List<ProductDetailResponseData> listProductResponse = [
    ProductDetailResponseData(
      categoriesID: 2,
      name: 'Hold Up Tool Storage Rack',
      price: 580.32,
      ratingStar: 3,
      images: ["http://dummyimage.com/150x200.png/5fa2dd/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 3,
      name: 'Tray - Foam, Square 4 - S',
      price: 725.73,
      ratingStar: 1,
      images: ["http://dummyimage.com/150x200.png/cc0000/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 4,
      name: 'Crab - Back Fin Meat, Canned',
      price: 305.11,
      ratingStar: 5,
      images: ["http://dummyimage.com/150x200.png/dddddd/000000"],
    ),
    ProductDetailResponseData(
      categoriesID: 2,
      name: 'Dc - Sakura Fu',
      price: 939.98,
      ratingStar: 2,
      images: ["http://dummyimage.com/150x200.png/cc0000/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 5,
      name: 'Mousse - Passion Fruit',
      price: 591.91,
      ratingStar: 1,
      images: ["http://dummyimage.com/150x200.png/ff4444/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 6,
      name: 'Towel Dispenser',
      price: 249.45,
      ratingStar: 1,
      images: ["http://dummyimage.com/150x200.png/cc0000/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 4,
      name: 'Magnotta Bel Paese Red',
      price: 671.43,
      ratingStar: 4,
      images: ["http://dummyimage.com/150x200.png/dddddd/000000"],
    ),
    ProductDetailResponseData(
      categoriesID: 6,
      name: 'Bread - Sour Batard',
      price: 420.05,
      ratingStar: 5,
      images: ["http://dummyimage.com/150x200.png/ff4444/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 5,
      name: 'Pork Ham Prager',
      price: 21.72,
      ratingStar: 3,
      images: ["http://dummyimage.com/150x200.png/ff4444/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 1,
      name: 'Bread - Wheat Baguette',
      price: 248.81,
      ratingStar: 5,
      images: ["http://dummyimage.com/150x200.png/cc0000/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 2,
      name: 'Hold Up Tool Storage Rack',
      price: 580.32,
      ratingStar: 3,
      images: ["http://dummyimage.com/150x200.png/5fa2dd/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 3,
      name: 'Tray - Foam, Square 4 - S',
      price: 725.73,
      ratingStar: 1,
      images: ["http://dummyimage.com/150x200.png/cc0000/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 4,
      name: 'Crab - Back Fin Meat, Canned',
      price: 305.11,
      ratingStar: 5,
      images: ["http://dummyimage.com/150x200.png/dddddd/000000"],
    ),
    ProductDetailResponseData(
      categoriesID: 2,
      name: 'Dc - Sakura Fu',
      price: 939.98,
      ratingStar: 2,
      images: ["http://dummyimage.com/150x200.png/cc0000/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 5,
      name: 'Mousse - Passion Fruit',
      price: 591.91,
      ratingStar: 1,
      images: ["http://dummyimage.com/150x200.png/ff4444/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 6,
      name: 'Towel Dispenser',
      price: 249.45,
      ratingStar: 1,
      images: ["http://dummyimage.com/150x200.png/cc0000/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 4,
      name: 'Magnotta Bel Paese Red',
      price: 671.43,
      ratingStar: 4,
      images: ["http://dummyimage.com/150x200.png/dddddd/000000"],
    ),
    ProductDetailResponseData(
      categoriesID: 6,
      name: 'Bread - Sour Batard',
      price: 420.05,
      ratingStar: 5,
      images: ["http://dummyimage.com/150x200.png/ff4444/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 5,
      name: 'Pork Ham Prager',
      price: 21.72,
      ratingStar: 3,
      images: ["http://dummyimage.com/150x200.png/ff4444/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 1,
      name: 'Bread - Wheat Baguette',
      price: 248.81,
      ratingStar: 5,
      images: ["http://dummyimage.com/150x200.png/cc0000/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 4,
      name: 'Crab - Back Fin Meat, Canned',
      price: 305.11,
      ratingStar: 5,
      images: ["http://dummyimage.com/150x200.png/dddddd/000000"],
    ),
    ProductDetailResponseData(
      categoriesID: 2,
      name: 'Dc - Sakura Fu',
      price: 939.98,
      ratingStar: 2,
      images: ["http://dummyimage.com/150x200.png/cc0000/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 5,
      name: 'Mousse - Passion Fruit',
      price: 591.91,
      ratingStar: 1,
      images: ["http://dummyimage.com/150x200.png/ff4444/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 6,
      name: 'Towel Dispenser',
      price: 249.45,
      ratingStar: 1,
      images: ["http://dummyimage.com/150x200.png/cc0000/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 4,
      name: 'Magnotta Bel Paese Red',
      price: 671.43,
      ratingStar: 4,
      images: ["http://dummyimage.com/150x200.png/dddddd/000000"],
    ),
    ProductDetailResponseData(
      categoriesID: 6,
      name: 'Bread - Sour Batard',
      price: 420.05,
      ratingStar: 5,
      images: ["http://dummyimage.com/150x200.png/ff4444/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 5,
      name: 'Pork Ham Prager',
      price: 21.72,
      ratingStar: 3,
      images: ["http://dummyimage.com/150x200.png/ff4444/ffffff"],
    ),
    ProductDetailResponseData(
      categoriesID: 1,
      name: 'Bread - Wheat Baguette',
      price: 248.81,
      ratingStar: 5,
      images: ["http://dummyimage.com/150x200.png/cc0000/ffffff"],
    ),
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
    List<ProductDetailResponseData> listProduct = [];
    listProductResponse.forEach((element) {
      if (element.categoriesID == categoriesResponseData.id) {
        listProduct.add(element);
      }
    });
    return listProduct;
  }
}
