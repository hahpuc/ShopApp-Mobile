import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/local/wish_list.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';
import 'package:furniture_shop/presentation/pages/customer/wish_list/bloc/wish_list_state.dart';
import 'package:localstorage/localstorage.dart';

class WishListBloc extends BaseBloc<WishListState> {
  final AppRepository appRepository;
  WishListBloc({required this.appRepository}) : super(WishListState());

  Future<void> getWishListData() async {
    emit(WishListLoadingState());
    final local = LocalStorage('ShopApp');
    final isReady = await local.ready;
    var wishList = WishList();
    var localWishList = await local.getItem('WishList');

    if (localWishList != null || isReady == true) {
      wishList.list = List<ProductDetailModel>.from(
        (localWishList as List).map(
          (item) => ProductDetailModel.fromJson(item),
        ),
      );
      emit(WishListGetDataSuccess(wishList));
    } else {
      emit(WishListGetDataFailed("error getting wishlist from local"));
    }
  }
}
