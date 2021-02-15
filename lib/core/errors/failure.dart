import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({this.message});
}

class CacheFailure extends Failure {}

class NoNetworkFailure extends Failure {}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return (failure as ServerFailure).message;
    case CacheFailure:
      return (failure as CacheFailure).properties.first.toString();
    default:
      return 'Unexpected error';
  }
}
