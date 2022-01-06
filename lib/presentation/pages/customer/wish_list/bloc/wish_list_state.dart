import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/local/wish_list.dart';

class WishListState extends BaseState {}

class WishListLoadingState extends WishListState {}

class WishListGetDataSuccess extends WishListState {
  final WishList data;

  WishListGetDataSuccess(this.data);
}

class WishListGetDataFailed extends WishListState {
  final String msg;

  WishListGetDataFailed(this.msg);
}
