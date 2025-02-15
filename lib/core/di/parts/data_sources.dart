part of '../dependency_injection.dart';

void _dataSources() {
  sl
    ..registerLazySingleton<DashboardRemoteDataSource>(() => DashboardRemoteDataSourceImpl(
      client: sl(),
    ))
    ..registerLazySingleton<AuthenticationDataSource>(() => AuthenticationDataSourceImpl(
      client: sl(),
    ));
}