import 'package:dartz/dartz.dart';
import 'package:nft_visor/core/failure.dart';
import 'package:nft_visor/core/use_case.dart';
import 'package:nft_visor/features/collection/domain/entities/collection.dart';
import 'package:nft_visor/features/collection/domain/repositories/collection_repository_base.dart';

class GetCollection
    extends UseCase<CollectionRepositoryBase, Collection, String> {
  GetCollection(CollectionRepositoryBase repository) : super(repository);

  @override
  Future<Either<Failure, Collection>> call(String data) {
    return repository.getCollection(id: data);
  }
}
