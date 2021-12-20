import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/categories_response.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';
import 'package:furniture_shop/data/model/response/test_product.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/pages/customer/home_tab/home_tab_state.dart';

class HomeTabPageBloc extends BlocBase<HomeTabPageState> {
  final AppRepository appRepository;

  HomeTabPageBloc({required this.appRepository}) : super(HomeTabPageState());

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
  List<ProductTest> listProductResponse = [
    ProductTest(
      categoriesID: 2,
      name: 'Hold Up Tool Storage Rack',
      price: 580.32,
      ratingStar: 3,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1636561690/products/Floor%20Lamp/ulxpvitpejqbsqtdwbkp.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 3,
      name: 'Tray - Foam, Square 4 - S',
      price: 725.73,
      ratingStar: 1,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1636561688/products/Floor%20Lamp/dmhgvhimkjbtsqknuvad.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 4,
      name: 'Crab - Back Fin Meat, Canned',
      price: 305.11,
      ratingStar: 5,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1636561690/products/Floor%20Lamp/ulxpvitpejqbsqtdwbkp.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 2,
      name: 'Dc - Sakura Fu',
      price: 939.98,
      ratingStar: 2,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120357/products/Gaming%20Table/g9xxtp6mtfdmh00kosmt.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 5,
      name: 'Mousse - Passion Fruit',
      price: 591.91,
      ratingStar: 1,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1636561688/products/Floor%20Lamp/dmhgvhimkjbtsqknuvad.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 6,
      name: 'Towel Dispenser',
      price: 249.45,
      ratingStar: 1,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120101/products/Folding%20Computer%20Desk/l0d5kxt8okip8doh3tos.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 4,
      name: 'Magnotta Bel Paese Red',
      price: 671.43,
      ratingStar: 4,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120352/products/Gaming%20Table/axmlvoybwtp7xekzz6eq.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 6,
      name: 'Bread - Sour Batard',
      price: 420.05,
      ratingStar: 5,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120352/products/Gaming%20Table/axmlvoybwtp7xekzz6eq.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 5,
      name: 'Pork Ham Prager',
      price: 21.72,
      ratingStar: 3,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1636561688/products/Floor%20Lamp/dmhgvhimkjbtsqknuvad.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 1,
      name: 'Bread - Wheat Baguette',
      price: 248.81,
      ratingStar: 5,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1636561692/products/Floor%20Lamp/c2e3vi6rbbqm3mypdmkd.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 2,
      name: 'Hold Up Tool Storage Rack',
      price: 580.32,
      ratingStar: 3,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120101/products/Folding%20Computer%20Desk/l0d5kxt8okip8doh3tos.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 3,
      name: 'Tray - Foam, Square 4 - S',
      price: 725.73,
      ratingStar: 1,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1636561692/products/Floor%20Lamp/c2e3vi6rbbqm3mypdmkd.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 4,
      name: 'Crab - Back Fin Meat, Canned',
      price: 305.11,
      ratingStar: 5,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120357/products/Gaming%20Table/g9xxtp6mtfdmh00kosmt.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 2,
      name: 'Dc - Sakura Fu',
      price: 939.98,
      ratingStar: 2,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1636561692/products/Floor%20Lamp/c2e3vi6rbbqm3mypdmkd.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 5,
      name: 'Mousse - Passion Fruit',
      price: 591.91,
      ratingStar: 1,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120352/products/Gaming%20Table/axmlvoybwtp7xekzz6eq.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 6,
      name: 'Towel Dispenser',
      price: 249.45,
      ratingStar: 1,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1636561692/products/Floor%20Lamp/c2e3vi6rbbqm3mypdmkd.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 4,
      name: 'Magnotta Bel Paese Red',
      price: 671.43,
      ratingStar: 4,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120101/products/Folding%20Computer%20Desk/l0d5kxt8okip8doh3tos.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 6,
      name: 'Bread - Sour Batard',
      price: 420.05,
      ratingStar: 5,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120097/products/Folding%20Computer%20Desk/yq2u0jj9mrwdwjzlfyh9.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 5,
      name: 'Pork Ham Prager',
      price: 21.72,
      ratingStar: 3,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120097/products/Folding%20Computer%20Desk/yq2u0jj9mrwdwjzlfyh9.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 1,
      name: 'Bread - Wheat Baguette',
      price: 248.81,
      ratingStar: 5,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1636561692/products/Floor%20Lamp/c2e3vi6rbbqm3mypdmkd.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 4,
      name: 'Crab - Back Fin Meat, Canned',
      price: 305.11,
      ratingStar: 5,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120352/products/Gaming%20Table/axmlvoybwtp7xekzz6eq.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 2,
      name: 'Dc - Sakura Fu',
      price: 939.98,
      ratingStar: 2,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120357/products/Gaming%20Table/g9xxtp6mtfdmh00kosmt.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 5,
      name: 'Mousse - Passion Fruit',
      price: 591.91,
      ratingStar: 1,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1636561692/products/Floor%20Lamp/c2e3vi6rbbqm3mypdmkd.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 6,
      name: 'Towel Dispenser',
      price: 249.45,
      ratingStar: 1,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120357/products/Gaming%20Table/g9xxtp6mtfdmh00kosmt.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 4,
      name: 'Magnotta Bel Paese Red',
      price: 671.43,
      ratingStar: 4,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120097/products/Folding%20Computer%20Desk/yq2u0jj9mrwdwjzlfyh9.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 6,
      name: 'Bread - Sour Batard',
      price: 420.05,
      ratingStar: 5,
      images: ["http://dummyimage.com/150x200.png/ff4444/ffffff"],
    ),
    ProductTest(
      categoriesID: 5,
      name: 'Pork Ham Prager',
      price: 21.72,
      ratingStar: 3,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120097/products/Folding%20Computer%20Desk/yq2u0jj9mrwdwjzlfyh9.jpg"
      ],
    ),
    ProductTest(
      categoriesID: 1,
      name: 'Bread - Wheat Baguette',
      price: 248.81,
      ratingStar: 5,
      images: [
        "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120357/products/Gaming%20Table/g9xxtp6mtfdmh00kosmt.jpg"
      ],
    ),
  ];

  Future<void> getCategoriesData() async {
    emit(HomeTabPageLoadingState());

    if (listCategories != null) {
      emit(HomeTabPageGetDataSuccessState(listCategories));
    } else
      emit(HomeTabPageGetDataFailState());
  }

  List<ProductTest>? getProductWithCategoriesID(int id) {
    List<ProductTest> listProduct = [];
    listProductResponse.forEach((element) {
      if (element.categoriesID == id) {
        listProduct.add(element);
      }
    });
    return listProduct;
  }
}
