import 'package:bloc_ecommerce/core/base/empty_param.dart';
import 'package:bloc_ecommerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/base/use_case.dart';
import '../entity/login_entity.dart';
import '../entity/sign_up_entity.dart';
import '../repository/authentication_repository.dart';

final class RegisterUseCase extends UseCase<SignUpResponseEntity, SignUpRequestEntity> {
  final AuthenticationRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, SignUpResponseEntity>> call({required SignUpRequestEntity params}) async {
    return repository.register(params);
  }
}

final class LoginUseCase extends UseCase<LoginResponseEntity, LoginRequestEntity> {
  final AuthenticationRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, LoginResponseEntity>> call({required LoginRequestEntity params}) async {
    return repository.login(params);
  }
}

final class LogoutUseCase extends UseCase<bool, EmptyParam> {
  final AuthenticationRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call({required EmptyParam params}) async {
    return repository.logout(params);
  }
}