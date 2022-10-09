import 'package:dartz/dartz.dart';
import 'package:nft_visor/core/failure.dart';
import 'package:nft_visor/features/collection/data/data_sources/collection_remote_data_source.dart';
import 'package:nft_visor/features/collection/domain/entities/collection.dart';

abstract class CollectionRepositoryBase {
  final CollectionRemoteDataSourceBase remote;

  CollectionRepositoryBase(this.remote);

  Future<Either<Failure, Collection>> getCollection({required String id});

  Future<Either<Failure, List<Collection>>> getCollections();
}
