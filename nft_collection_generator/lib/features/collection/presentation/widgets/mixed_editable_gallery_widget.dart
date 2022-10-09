import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft_visor/features/collection/domain/entities/collection_image.dart';
import 'package:nft_visor/features/collection/domain/entities/collection_layer.dart';

class MixedEditableGalleryWidget extends StatefulWidget {
  final List<CollectionLayer> layers;
  final List<List<CollectionImage>> imagesInLayers;
  final numPages;
  final currentPage;
  final totalItems;
  final limit;

  const MixedEditableGalleryWidget(
    this.layers,
    this.numPages,
    this.currentPage,
    this.totalItems,
    this.limit,
    this.imagesInLayers, {
    Key? key,
  }) : super(key: key);

  @override
  _EditableGalleryWidgetState createState() => _EditableGalleryWidgetState();
}

class _EditableGalleryWidgetState extends State<MixedEditableGalleryWidget> {
  int currentPageItemsCount = 0;

  var st1 = GoogleFonts.urbanist(fontSize: 32, fontWeight: FontWeight.bold);
  var st2 = GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.w500);

  @override
  void initState() {
    super.initState();
  }

  get selectedChunkOfImages {
    var selectRangeTo = (widget.currentPage * widget.limit + widget.limit);
    var selectRangeFrom = widget.currentPage * widget.limit;
    if (selectRangeTo > widget.totalItems) {
      selectRangeTo = widget.totalItems;
    }
    return widget.imagesInLayers
        .getRange(selectRangeFrom, selectRangeTo)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rareImages = [];
    for (var value in widget.layers.where((e) => e.isRare).toList()) {
      for (var element in value.images) {
        rareImages.add(imageMultiple([Image.network(element.name)], 0));
      }
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: selectedChunkOfImages.length,
      itemBuilder: (ctx, i) {
        return square(selectedChunkOfImages[i], i);
      },
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
    );
  }

  Widget imageMultiple(List<Widget> images, int index) {
    return Stack(
      children: [
        ...images,
      ],
    );
  }

  Widget square(List<CollectionImage> images, int index) {
    List<Widget> widgets = [];
    for (int i = 0; i < images.length; i++) {
      widgets.add(Image.network(images[i].name));
    }
    return imageMultiple(widgets, index);
  }

  Widget imageWidget(CollectionImage e) {
    return Image.network(e.name, fit: BoxFit.cover);
  }
}
