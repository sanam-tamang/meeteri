
import 'package:dartz/dartz.dart';
import 'package:meeteri/core/failure/failure.dart';



typedef FutureEither<Type> = Future<Either<Failure, Type>>;
