import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:furniture_shop/bloc/locale/locale_state.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/auth/sign_in/sign_in_page.dart';
import 'package:furniture_shop/presentation/pages/boarding/boarding_page.dart';
import 'package:furniture_shop/presentation/pages/customer/home/home_page.dart';
import 'package:furniture_shop/presentation/widgets/base/app_configs_widgets.dart';
import 'package:furniture_shop/values/app_utils.dart';

import 'bloc/app/app_bloc.dart';
import 'bloc/locale/locale_bloc.dart';
import 'configs/flavor.dart';
import 'generated/localization/l10n.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppBloc()),
        BlocProvider(create: (context) => LocaleBloc(locator.get())),
      ],
      child: BlocBuilder<LocaleBloc, LocaleState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return MaterialApp(
              title: 'furniture_shop',
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              theme: _buildThemeData(context),
              builder: EasyLoading.init(),
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: state.locale,
              onGenerateRoute: Routes.generateRoute,
              home: _getHomeScreen(),
            );
          }),
    );
  }

  ThemeData _buildThemeData(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.blue,
      fontFamily: FontFamily.nutinoSans,
      textTheme: Theme.of(context)
          .textTheme
          .apply(bodyColor: Colors.black, fontFamily: FontFamily.nutinoSans),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light, // 2
      ),
    );
  }

  static void initSystemTheme() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, // this one for android
        statusBarBrightness: Brightness.light // this one for iOS
        ));
  }

  static Future<void> appRunner(FlavorConfig flavorConfig) async {
    // Ready to call native code
    WidgetsFlutterBinding.ensureInitialized();

    // System overlay
    MyApp.initSystemTheme();

    // IoC
    await setupServiceLocator();

    return runApp(AppConfigWidget(
      flavorConfig: flavorConfig,
      child: MyApp(),
    ));
  }

  Widget _getHomeScreen() {
    if (AppUtils.needOnboarding()) {
      return BoardingPage();
    } else if (AppUtils.isLoggedIn()) {
      return HomePage();
    } else {
      return SignInPage();
    }
  }
}
