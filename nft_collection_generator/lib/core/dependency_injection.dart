import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nft_visor/core/graph_ql_service.dart';
import 'package:nft_visor/features/collection/data/data_sources/collection_remote_data_source.dart';
import 'package:nft_visor/features/collection/data/repositories/collection_repository.dart';
import 'package:nft_visor/features/collection/domain/repositories/collection_repository_base.dart';
import 'package:nft_visor/features/collection/domain/use_cases/get_collection.dart';
import 'package:nft_visor/features/collection/domain/use_cases/get_collections.dart';
import 'package:nft_visor/features/collection/presentation/manager/collection_detail_page_bloc.dart';
import 'package:nft_visor/features/collection/presentation/manager/collections_home_page_bloc.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  String host = dotenv.env['HOST']!;

  getIt.registerLazySingleton<Client>(() => Client());

  getIt.registerLazySingleton<GraphQlService>(
    () => GraphQlService(host: host, client: getIt()),
  );

  getIt.registerLazySingleton<CollectionRemoteDataSourceBase>(
    () => CollectionRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<CollectionRepositoryBase>(
    () => CollectionRepository(getIt()),
  );

  getIt.registerLazySingleton<GetCollections>(
    () => GetCollections(getIt()),
  );

  getIt.registerLazySingleton<GetCollection>(
    () => GetCollection(getIt()),
  );

  getIt.registerLazySingleton<CollectionsHomePageBloc>(
    () => CollectionsHomePageBloc(getCollections: getIt()),
  );

  getIt.registerLazySingleton<CollectionDetailPageBloc>(
    () => CollectionDetailPageBloc(getCollection: getIt()),
  );
}
