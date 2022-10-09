import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nft_visor/core/failure.dart';
import 'package:nft_visor/features/collection/domain/entities/collection.dart';
import 'package:nft_visor/features/collection/domain/use_cases/get_collection.dart';

part 'collection_detail_page_event.dart';

part 'collection_detail_page_state.dart';

class CollectionDetailPageBloc
    extends Bloc<CollectionDetailPageEvent, CollectionDetailPageState> {
  final GetCollection getCollection;

  CollectionDetailPageBloc({required this.getCollection})
      : super(OnBlocLoad()) {
    on<CollectionDetailPageEvent>((event, emit) async {
      if (event is ActionGetCollectionDetail) {
        emit(OnPageLoading());
        var result = await getCollection.call(event.id);
        result.fold(
          (failure) => emit(OnPageError(failure)),
          (collection) => emit(OnCollectionLoad(collection)),
        );
      }
    });
  }
}
