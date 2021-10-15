import 'package:flutter/material.dart';
import 'package:furniture_shop/bloc/base/base_state.dart';

class LocaleState extends BaseState {
  final Locale locale;

  LocaleState(this.locale);
}
