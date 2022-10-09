import 'package:dartz/dartz.dart';
import 'package:nft_visor/core/failure.dart';

abstract class UseCase<A, T, Map> {
  final A repository;

  UseCase(this.repository);

  Future<Either<Failure, T>> call(Map data);
}
