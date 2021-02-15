import '../errors/exceptions.dart';
import '../errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CacheFailureRequestMixin {
  Future<Either<Failure, T>> withCacheFailureRequest<T>(Function body) async {
    try {
      return Right(await body());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
