import 'dart:io';

import 'package:bloc_ecommerce/app_config.dart';
import 'package:bloc_ecommerce/core/extra/app_observer.dart';
import 'package:bloc_ecommerce/core/navigation/router.dart';
import 'package:bloc_ecommerce/core/theme/theme.dart';
import 'package:bloc_ecommerce/features/authentication/domain/use_case/authentication_use_case.dart';
import 'package:bloc_ecommerce/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/use_cases/get_dashboard_products_category.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/business_logic/dashboard_products_category_bloc/dashboard_products_category_bloc.dart';
import 'package:bloc_ecommerce/features/on_boarding/presentation/business_logic/splash_bloc/splash_bloc.dart';
import 'package:bloc_ecommerce/core/di/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/presentation/bloc/authentication_bloc.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashBloc()),
        BlocProvider(create: (context) => AuthenticationBloc(
          loginUseCase: sl<LoginUseCase>(),
          logoutUseCase: sl<LogoutUseCase>(),
        )),
        BlocProvider(create: (context) => AuthenticationCubit()),
        BlocProvider(
          create: (context) => DashboardProductsCategoryBloc(
            getDashboardProductsCategory: sl<GetDashboardProductsCategory>(),
          ),
        ),
      ],
      child: MediaQuery.withClampedTextScaling(
        maxScaleFactor: 1.5,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppConfig.appName,
          theme: context.themeData,
          themeMode: ThemeMode.system,

          /// Navigation
          routerConfig: appRouteConfig,
          // initialRoute: Routes.kRoot,
          // onGenerateRoute: RouteGenerator.generateRoute,
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
