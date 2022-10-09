import 'package:dartz/dartz.dart';
import 'package:nft_visor/core/failure.dart';
import 'package:nft_visor/core/use_case.dart';
import 'package:nft_visor/features/collection/domain/entities/collection.dart';
import 'package:nft_visor/features/collection/domain/repositories/collection_repository_base.dart';

class GetCollections
    extends UseCase<CollectionRepositoryBase, List<Collection>, void> {
  GetCollections(CollectionRepositoryBase repository) : super(repository);

  @override
  Future<Either<Failure, List<Collection>>> call(void data) {
    return repository.getCollections();
  }
}
