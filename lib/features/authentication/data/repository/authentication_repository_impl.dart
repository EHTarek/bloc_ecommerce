import 'package:bloc_ecommerce/core/base/empty_param.dart';
import 'package:bloc_ecommerce/core/error/exception.dart';
import 'package:bloc_ecommerce/core/error/failure.dart';
import 'package:bloc_ecommerce/core/extra/network_info.dart';
import 'package:bloc_ecommerce/features/authentication/data/data_source/authentication_local_data_source.dart';
import 'package:bloc_ecommerce/features/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:bloc_ecommerce/features/authentication/data/model/login_model.dart';
import 'package:bloc_ecommerce/features/authentication/data/model/sign_up_model.dart';
import 'package:bloc_ecommerce/features/authentication/domain/entity/login_entity.dart';
import 'package:bloc_ecommerce/features/authentication/domain/entity/sign_up_entity.dart';
import 'package:bloc_ecommerce/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';


final class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource remote;
  final AuthenticationLocalDataSource local;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    required this.remote, required this.networkInfo, required this.local
  });

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

  @override
  Future<Either<Failure, LoginResponseEntity>> getUserData() async {
    try {
      return Right(await local.getUserData());
    } on UnauthorizedException {
      return const Left(TokenInvalid(message: 'Invalid Token'));
    } catch (_) {
      return const Left(ServerFailure(message: 'Something went wrong!'));
    }
  }
}