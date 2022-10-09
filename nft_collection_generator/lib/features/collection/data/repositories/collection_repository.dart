import 'package:dartz/dartz.dart';
import 'package:nft_visor/core/failure.dart';
import 'package:nft_visor/features/collection/data/data_sources/collection_remote_data_source.dart';
import 'package:nft_visor/features/collection/domain/entities/collection.dart';
import 'package:nft_visor/features/collection/domain/repositories/collection_repository_base.dart';

class CollectionRepository extends CollectionRepositoryBase {
  CollectionRepository(CollectionRemoteDataSourceBase remote) : super(remote);

  @override
  Future<Either<Failure, Collection>> getCollection({
    required String id,
  }) async {
    try {
      return Right(await remote.getCollection(id: id));
    } catch (e) {
      return Left(UnhandledFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Collection>>> getCollections() async {
    try {
      return Right(await remote.getCollections());
    } catch (e) {
      return Left(UnhandledFailure(e.toString()));
    }
  }
}
