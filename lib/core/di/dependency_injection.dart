import 'package:bloc_ecommerce/core/api/api_client.dart';
import 'package:bloc_ecommerce/core/extra/network_info.dart';
import 'package:bloc_ecommerce/core/cached/preferences.dart';
import 'package:bloc_ecommerce/core/extra/token_service.dart';
import 'package:bloc_ecommerce/features/authentication/domain/repository/authentication_repository.dart';
import 'package:bloc_ecommerce/features/authentication/domain/use_case/authentication_use_case.dart';
import 'package:bloc_ecommerce/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:bloc_ecommerce/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_ecommerce/features/dashboard/data/data_source/dashboard_remote_data_source.dart';
import 'package:bloc_ecommerce/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/use_cases/get_dashboard_products_category.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/business_logic/dashboard_products_category_bloc/dashboard_products_category_bloc.dart';
import 'package:bloc_ecommerce/core/extra/log.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/authentication/data/data_source/authentication_data_source.dart';
import '../../features/authentication/data/repository/authentication_repository_impl.dart';

part 'parts/use_cases.dart';
part 'parts/repositories.dart';
part 'parts/data_sources.dart';
part 'parts/blocs.dart';
part 'parts/core.dart';
part 'parts/externals.dart';
part 'parts/services.dart';


GetIt sl = GetIt.instance;

void diInit() {
  ///! External
  _externals();

  ///! Core
  _core();

  ///! Service
  _services();

  ///! Use Case
  _useCases();

  ///! Repository
  _repositories();

  ///! Data Source
  _dataSources();

  ///! Blocs
  _blocs();
}
