import 'package:flutter/material.dart';
import 'package:nft_visor/core/styles.dart';
import 'package:nft_visor/features/collection/domain/entities/collection.dart';

class CollectionsGridWidget extends StatelessWidget {
  final List<Collection> collections;
  final Function(Collection collection) onTap;

  const CollectionsGridWidget({
    Key? key,
    required this.collections,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return collectionsList;
  }

  get collectionsList => GridView.count(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(50),
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        crossAxisCount: 5,
        children: <Widget>[
          ...collections
              .map<Widget>(
                (a) => InkWell(
                  onTap: () => onTap(a),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(a.banner, fit: BoxFit.cover),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                end: Alignment.topCenter,
                                begin: Alignment.bottomCenter,
                                colors: [
                                  Colors.black87,
                                  Colors.black54,
                                  Colors.black12,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(a.name, style: style4),
                                Text(a.authorName, style: style5),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      );
}
