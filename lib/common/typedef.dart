
import 'package:dartz/dartz.dart';
import '/core/failure/failure.dart';



typedef FutureEither<Type> = Future<Either<Failure, Type>>;
