import 'dart:typed_data';

import 'package:nft_visor/core/entity.dart';


abstract class CollectionImage extends Entity {
  final String name;

  CollectionImage({
    required this.name,
  });
}
