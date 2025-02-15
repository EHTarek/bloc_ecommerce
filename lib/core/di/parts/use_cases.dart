part of '../dependency_injection.dart';

void _useCases() {
  sl
    ..registerLazySingleton(() => GetDashboardProductsCategory(
      dashboardRepository: sl(),
    ))
    ..registerLazySingleton(() => LoginUseCase(sl()))
    ..registerLazySingleton(() => LogoutUseCase(sl()));
}