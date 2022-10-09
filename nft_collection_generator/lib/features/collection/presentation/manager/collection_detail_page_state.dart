part of 'collection_detail_page_bloc.dart';

@immutable
abstract class CollectionDetailPageState {}

class OnBlocLoad extends CollectionDetailPageState {}

class OnCollectionLoad extends CollectionDetailPageState {
  final Collection collection;

  OnCollectionLoad(this.collection);
}

class OnPageLoading extends CollectionDetailPageState {}

class OnPageError extends CollectionDetailPageState {
  final Failure failure;

  OnPageError(this.failure);
}
