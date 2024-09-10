import 'package:dartz/dartz.dart';

import '../error/failure.dart';

// Abstract class for use cases
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// No parameters use case
class NoParams {}
