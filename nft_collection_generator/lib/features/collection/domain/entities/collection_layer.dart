
import 'package:nft_visor/core/entity.dart';
import 'package:nft_visor/features/collection/domain/entities/collection_image.dart';

abstract class CollectionLayer extends Entity {
  String name;
  List<CollectionImage> images;
  late int index;
  bool selected, isRare;

  CollectionLayer({
    required this.name,
    required this.images,
    required this.isRare,
    this.selected = false,
  });
}
