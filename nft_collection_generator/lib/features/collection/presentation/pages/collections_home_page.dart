import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft_visor/core/dependency_injection.dart';
import 'package:nft_visor/core/extensions.dart';
import 'package:nft_visor/core/strings.dart';
import 'package:nft_visor/core/styles.dart';
import 'package:nft_visor/features/collection/domain/entities/collection.dart';
import 'package:nft_visor/features/collection/presentation/manager/collections_home_page_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_visor/features/collection/presentation/pages/collection_detail_page.dart';
import 'package:nft_visor/features/collection/presentation/widgets/collections_grid_widget.dart';

class CollectionsHomePage extends StatefulWidget {
  static const route = '/';

  const CollectionsHomePage({Key? key}) : super(key: key);

  @override
  State<CollectionsHomePage> createState() => _CollectionsHomePage();
}

class _CollectionsHomePage extends State<CollectionsHomePage> {
  final _bloc = getIt<CollectionsHomePageBloc>();

  get style3 => GoogleFonts.urbanist(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  List<Collection> collections = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(ActionGetCollections());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocConsumer<CollectionsHomePageBloc, CollectionsHomePageState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is OnCollectionsLoad) collections = state.collections;
        },
        builder: (context, state) {
          if (state is OnPageLoading) return progress();
          if (state is OnPageError) return error(state);
          return buildScaffold();
        },
      ),
    );
  }

  Center error(OnPageError state) => Center(child: Text(state.failure.message));

  Center progress() => const Center(child: CircularProgressIndicator());

  Scaffold buildScaffold() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            topSection(),
            bottomSection(
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(padding: const EdgeInsets.all(50), child: subtitle),
                  CollectionsGridWidget(
                    collections: collections,
                    onTap: onCollectionSelected,
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget topSection() {
    return SizedBox(
      height: 700,
      child: Row(
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.fromLTRB(150, 0, 150, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [title, const SizedBox(height: 20), caption],
              ),
            ),
          ),
          Flexible(
            child: Center(
              child: SizedBox(width: 400, height: 400, child: topImage),
            ),
          ),
        ],
      ),
    );
  }

  Container bottomSection(Widget child) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: ["#30277A".parseToColor, "#090016".parseToColor],
          ),
        ),
        child: child,
      );

  Image get topImage => Image.asset('assets/img.png');

  Text get caption => Text(homeCaption, style: style2);

  Text get title => Text(homeTitle, style: style1);

  Text get subtitle =>
      Text(homeSubtitle, style: style3, textAlign: TextAlign.center);

  onCollectionSelected(Collection collection) {
    Navigator.of(context)
        .pushNamed("${CollectionDetailPage.route}/${collection.id}");
  }
}
