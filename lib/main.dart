import 'dart:io';

import 'package:bloc_ecommerce/app_config.dart';
import 'package:bloc_ecommerce/core/di/dependency_injection.dart';
import 'package:bloc_ecommerce/core/extra/app_observer.dart';
import 'package:bloc_ecommerce/core/navigation/router.dart';
import 'package:bloc_ecommerce/core/theme/theme.dart';
import 'package:bloc_ecommerce/features/authentication/presentation/business_logic/authentication_bloc/authentication_bloc.dart';
import 'package:bloc_ecommerce/features/authentication/presentation/business_logic/authentication_cubit/authentication_cubit.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/business_logic/all_products_bloc/all_products_bloc.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/business_logic/cart_cubit/cart_cubit.dart';
import 'package:bloc_ecommerce/features/on_boarding/presentation/business_logic/splash_bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    // [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
  );

  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = AppObserver();
  diInit();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = appRouteConfig;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashBloc()),
        BlocProvider(create: (context) => AuthenticationBloc(
          loginUseCase: sl(), logoutUseCase: sl(), getUserData: sl(),
        )),
        BlocProvider(create: (context) => AuthenticationCubit()),
        BlocProvider(create: (context) => AllProductsBloc(
          getProductsUseCase: sl(),
        )),
        BlocProvider(create: (context) => CartCubit(
          addToCartUseCase: sl(), removeFromCartUseCase: sl(),
          loadCartUseCase: sl(), clearCartUseCase: sl(),
        )),
      ],
      child: MediaQuery.withClampedTextScaling(
        maxScaleFactor: 1,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppConfig.appName,
          theme: context.themeData,
          themeMode: ThemeMode.system,

          /// Navigation
          routerConfig: _router,
          restorationScopeId: 'app_router',
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
