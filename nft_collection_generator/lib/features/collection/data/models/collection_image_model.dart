
import 'package:nft_visor/features/collection/domain/entities/collection_image.dart';

class CollectionImageModel extends CollectionImage {
  CollectionImageModel({
    required String name,
  }) : super(
          name: name,
        );

  @override
  Map<String, dynamic> toJson() {
    return {'name': name};
  }

  factory CollectionImageModel.fromJson({required Map map}) {
    return CollectionImageModel(
      name: map['path'],
    );
  }
}
