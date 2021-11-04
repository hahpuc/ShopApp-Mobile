import 'package:flutter_easyloading/flutter_easyloading.dart';

mixin LoadingViewMixin {
  void showLoading({String? msg}) {
    EasyLoading.show(status: msg, maskType: EasyLoadingMaskType.black);
  }

  void dismissLoading() {
    EasyLoading.dismiss();
  }
}
