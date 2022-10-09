import 'package:nft_visor/features/collection/data/models/collection_image_model.dart';
import 'package:nft_visor/features/collection/domain/entities/collection_image.dart';
import 'package:nft_visor/features/collection/domain/entities/collection_layer.dart';

class CollectionLayerModel extends CollectionLayer {
  CollectionLayerModel({
    required String name,
    required bool isRare,
    required List<CollectionImage> images,
  }) : super(name: name, images: images,isRare: isRare);

  factory CollectionLayerModel.fromJson({required Map<String, dynamic> map}) {
    List<CollectionImage> list = map.containsKey("images")
        ? map['images']
            .map<CollectionImage>((a) => CollectionImageModel.fromJson(map: a))
            .toList()
        : [];

    return CollectionLayerModel(
      name: map['name'],
      isRare: map['isRare'],
      images: list,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
