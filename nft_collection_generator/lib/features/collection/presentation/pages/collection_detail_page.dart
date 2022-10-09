import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_visor/core/collection_helper.dart';
import 'package:nft_visor/core/dependency_injection.dart';
import 'package:nft_visor/core/extensions.dart';
import 'package:nft_visor/core/styles.dart';
import 'package:nft_visor/features/collection/domain/entities/collection.dart';
import 'package:nft_visor/features/collection/domain/entities/collection_image.dart';
import 'package:nft_visor/features/collection/presentation/manager/collection_detail_page_bloc.dart';
import 'package:nft_visor/features/collection/presentation/widgets/mixed_editable_gallery_widget.dart';
import 'package:number_paginator/number_paginator.dart';

class CollectionDetailPage extends StatefulWidget {
  static const route = '/detail';
  static const name = 'detail';
  final String id;

  const CollectionDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<CollectionDetailPage> createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {
  final _bloc = getIt<CollectionDetailPageBloc>();
  Collection? collection;

  @override
  void initState() {
    super.initState();
    _bloc.add(ActionGetCollectionDetail(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CollectionDetailPageBloc, CollectionDetailPageState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is OnCollectionLoad) {
            collection = state.collection;
            generateCollection();
            calculatePages();
          }
        },
        builder: (context, state) {
          if (state is OnPageLoading) return progress();
          if (state is OnPageError) return error(state.failure.message);
          if (state is OnCollectionLoad) return onLoad();
          return error("Estado desconocido $state");
        },
      ),
    );
  }

  Center error(String message) => Center(child: Text(message));

  Center progress() => const Center(child: CircularProgressIndicator());

  int _numPages = 0;
  int _currentPage = 0;
  int totalItems = 0;
  int limit = 18;

  calculatePages() {
    totalItems = imagesMixed.length;
    _numPages = (totalItems / limit).ceil();
    _currentPage = 0;
  }

  Widget onLoad() {
    if (collection == null) return Container();
    return background(
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                constraints: const BoxConstraints(maxWidth: 1400),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        leftSection(),
                        const SizedBox(width: 30),
                        rightSection(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    pagination(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget pagination() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: NumberPaginator(
          buttonSelectedForegroundColor: "#FFFFFF".parseToColor,
          buttonUnselectedForegroundColor: "#FFFFFF".parseToColor,
          buttonSelectedBackgroundColor: "#5AA624".parseToColor,
          numberPages: _numPages,
          onPageChange: (int index) {
            _currentPage = index;
            setState(() => {});
            // handle page change...
          },
        ),
      ),
    );
  }

  Widget rightSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            collection!.name,
            style: style1.copyWith(color: Colors.white),
          ),
          Text(
            collection!.authorName,
            style: style2.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 90,
            child: Text(
              collection!.detail,
              style: style5.copyWith(
                color: Colors.white,
              ),
              maxLines: 3,
            ),
          ),
          const SizedBox(height: 30),
          panelMixedLayers(),
        ],
      ),
    );
  }

  Widget leftSection() {
    return SizedBox(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          collection!.banner,
          fit: BoxFit.cover,
        ),
      ),
      width: 350,
      height: 700,
    );
  }

  List<List<CollectionImage>> imagesMixed = [];

  Widget panelMixedLayers() => MixedEditableGalleryWidget(
        collection!.layers,
        _numPages,
        _currentPage,
        totalItems,
        limit,
        imagesMixed,
      );

  generateCollection() async {
    var helper = CollectionHelper(
      collection!.layers.where((e) => !e.isRare).toList(),
    );
    helper.generateVariants;
    imagesMixed = demoMethod(helper.mixedLayers);
    setState(() => {});
  }

  List<List<CollectionImage>> demoMethod(rawImagesInLayers) {
    if (rawImagesInLayers == null) [];
    List<List<CollectionImage>> all = [];
    for (var i = 0; i < rawImagesInLayers!.length; i++) {
      List<CollectionImage> images = [];
      for (var e = 0; e < rawImagesInLayers[i].length; e++) {
        images.add(getImageFromLayerByIndex(e, rawImagesInLayers[i][e]));
      }
      all.add(images);
    }

    for (var rareLayer
        in collection!.layers.where((element) => element.isRare).toList()) {
      for (var value in rareLayer.images) {
        all.add([value]);
      }
    }
    return all;
  }

  CollectionImage getImageFromLayerByIndex(int layerIndex, int imageIndex) {
    return collection!.layers[layerIndex].images[imageIndex];
  }

  Container background(Widget child) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: ["#30277A".parseToColor, "#090016".parseToColor],
          ),
        ),
        child: Center(child: child),
      );
}
