part of '../dependency_injection.dart';

void _blocs() {
  sl
    ..registerFactory<DashboardProductsCategoryBloc>(() => DashboardProductsCategoryBloc(
      getDashboardProductsCategory: sl(),
    ))
    ..registerFactory<AuthenticationBloc>(() => AuthenticationBloc(
      loginUseCase: sl(), logoutUseCase: sl(),
    ))
    ..registerFactory<AuthenticationCubit>(() => AuthenticationCubit());
}