import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

// Concrete implementation for network failures
class NetworkFailure extends Failure {}

// Concrete implementation for server failures
class ServerFailure extends Failure {}

// Concrete implementation for cache failures
class CacheFailure extends Failure {}
