
import 'package:nft_visor/core/entity.dart';
import 'package:nft_visor/features/collection/domain/entities/collection_layer.dart';

abstract class Collection extends Entity {
  String id;
  String name;
  String banner;
  String detail;
  String authorName;
  String authorEmail;
  List<CollectionLayer> layers;

  Collection({
    required this.id,
    required this.name,
    required this.banner,
    required this.detail,
    required this.authorName,
    required this.authorEmail,
    required this.layers,
  });
}
