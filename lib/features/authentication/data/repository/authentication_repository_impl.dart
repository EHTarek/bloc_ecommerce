

import 'package:bloc_ecommerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/base/empty_param.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/extra/network_info.dart';
import '../../domain/entity/login_entity.dart';
import '../../domain/entity/sign_up_entity.dart';
import '../../domain/repository/authentication_repository.dart';
import '../data_source/authentication_data_source.dart';
import '../model/login_model.dart';
import '../model/sign_up_model.dart';

final class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationDataSource remote;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({required this.remote, required this.networkInfo});

  @override
  Future<Either<Failure, SignUpResponseEntity>> register(SignUpRequestEntity data) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remote.register(data.toJson()));
      } on UnauthorizedException {
        return const Left(TokenInvalid(message: 'Invalid Token'));
      } catch (_) {
        return const Left(ServerFailure(message: 'Something went wrong!'));
      }
    } else {
      return const Left(ConnectionFailure(message: 'No Internet Connection!'));
    }
  }

  @override
  Future<Either<Failure, LoginResponseEntity>> login(LoginRequestEntity data) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remote.login(data.toJson()));
      } on UnauthorizedException {
        return const Left(TokenInvalid(message: 'Email or Password is incorrect!'));
      } catch (_) {
        return const Left(ServerFailure(message: 'Something went wrong!'));
      }
    } else {
      return const Left(ConnectionFailure(message: 'No Internet Connection!'));
    }
  }

  @override
  Future<Either<Failure, bool>> logout(EmptyParam data) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remote.logout());
      } on UnauthorizedException {
        return const Left(TokenInvalid(message: 'Invalid Token'));
      } catch (_) {
        return const Left(ServerFailure(message: 'Something went wrong!'));
      }
    } else {
      return const Left(ConnectionFailure(message: 'No Internet Connection!'));
    }
  }
}