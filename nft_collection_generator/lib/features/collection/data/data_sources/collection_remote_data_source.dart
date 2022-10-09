import 'package:nft_visor/core/graph_ql_service.dart';
import 'package:nft_visor/features/collection/data/models/collection_model.dart';
import 'package:nft_visor/features/collection/domain/entities/collection.dart';

abstract class CollectionRemoteDataSourceBase {
  final GraphQlService gqlService;

  CollectionRemoteDataSourceBase(this.gqlService);

  Future<List<Collection>> getCollections();

  Future<Collection> getCollection({required String id});
}

class CollectionRemoteDataSource extends CollectionRemoteDataSourceBase {
  CollectionRemoteDataSource(GraphQlService httpService) : super(httpService);

  @override
  Future<Collection> getCollection({required String id}) async {
    const query = '''
     Result(\$id: String!) {
      getCollection(id: \$id) {
       _id
        authorEmail
        authorName
        detail
        name
        banner
        layers {
          name
          isRare
          images {
            path
          }
        }
      }
    }
    ''';
    final result = await gqlService.query(query, {'id': id});
    var data =  CollectionModel.fromJson(map: result['data']["getCollection"]);
    return data;
  }

  @override
  Future<List<Collection>> getCollections() async {
    const skip = 0;
    const limit = 100;
    const query = '''
    Result(\$skip: Float!, \$limit: Float!) {
      getCollections(skip: \$skip, limit: \$limit) {
        _id
        authorEmail
        authorName
        detail
        name
        banner
      }
  }''';
    final result = await gqlService.query(
      query,
      {"skip": skip, "limit": limit},
    );
    return result['data']["getCollections"]
        .map<Collection>((c) => CollectionModel.fromJson(map: c))
        .toList();
  }
}
