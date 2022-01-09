import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/exceptions/app_exception.dart';
import 'package:furniture_shop/data/model/response/base/base_response.dart';

abstract class BaseBloc<T extends BaseState> extends Cubit<T> {
  BaseBloc(T state) : super(state);

  ///
  /// Get error message to show
  ///
  String getErrorMessage(Result result) {
    String? msg = "";
    if (result.exception != null) {
      if (result.exception is NoInternetException) {
        msg = 'No Internet Connection';
      }
    } else if (result.response != null) {
      msg = result.response?.errorMsg;
    }

    if (msg == null || msg.isEmpty) {
      msg = "Error Occurred";
    }
    return msg;
  }
}
