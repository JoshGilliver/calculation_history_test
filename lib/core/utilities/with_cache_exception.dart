import '../errors/exceptions.dart';

abstract class CacheExceptionRequestMixin {
  Future<T> withCacheExceptionRequest<T>(Function body) async {
    try {
      return await body();
    } catch (e) {
      throw CacheException();
    }
  }
}
