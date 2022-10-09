import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nft_visor/core/failure.dart';
import 'package:nft_visor/features/collection/domain/entities/collection.dart';
import 'package:nft_visor/features/collection/domain/use_cases/get_collections.dart';

part 'collections_home_page_event.dart';

part 'collections_home_page_state.dart';

class CollectionsHomePageBloc
    extends Bloc<CollectionsHomePageEvent, CollectionsHomePageState> {
  final GetCollections getCollections;

  CollectionsHomePageBloc({
    required this.getCollections,
  }) : super(OnBlocLoad()) {
    on<CollectionsHomePageEvent>((event, emit) async {

      if (event is ActionGetCollections) {
        emit(OnPageLoading());
        var result = await getCollections.call(null);
        result.fold(
          (failure) => emit(OnPageError(failure)),
          (collections) => emit(OnCollectionsLoad(collections)),
        );
      }

    });
  }
}
