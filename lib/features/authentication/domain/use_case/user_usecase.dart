import 'package:bloc_ecommerce/core/base/empty_param.dart';
import 'package:bloc_ecommerce/core/base/use_case.dart';
import 'package:bloc_ecommerce/core/error/failure.dart';
import 'package:bloc_ecommerce/features/authentication/domain/entity/login_entity.dart';
import 'package:bloc_ecommerce/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

final class GetUserData extends UseCase<LoginResponseEntity, EmptyParam> {
  final AuthenticationRepository repository;

  GetUserData(this.repository);

  @override
  Future<Either<Failure, LoginResponseEntity>> call({required EmptyParam params}) async {
    return repository.getUserData();
  }
}
