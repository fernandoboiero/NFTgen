import 'package:nft_visor/features/collection/data/models/collection_layer_model.dart';
import 'package:nft_visor/features/collection/domain/entities/collection.dart';
import 'package:nft_visor/features/collection/domain/entities/collection_layer.dart';

class CollectionModel extends Collection {
  CollectionModel({
    required String id,
    required String name,
    required String authorEmail,
    required String authorName,
    required String detail,
    required String banner,
    required List<CollectionLayer> layers,
  }) : super(
          name: name,
          layers: layers,
          authorEmail: authorEmail,
          authorName: authorName,
          detail: detail,
          banner: banner,
          id: id,
        );

  @override
  Map<String, dynamic> toJson() {
    return {

    };
  }

  factory CollectionModel.fromJson({required Map<String, dynamic> map}) {

    List<CollectionLayer> list = map.containsKey('layers')
        ? map['layers']
            .map<CollectionLayerModel>(
                (a) => CollectionLayerModel.fromJson(map: a))
            .toList()
        : [];

    return CollectionModel(
      id: map['_id'],
      name: map['name'],
      authorEmail: map['authorEmail'],
      authorName: map['authorName'],
      detail: map['detail'],
      layers: list,
      banner: map["banner"],
    );
  }
}
