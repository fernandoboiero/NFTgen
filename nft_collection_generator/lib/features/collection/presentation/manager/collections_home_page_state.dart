part of 'collections_home_page_bloc.dart';

@immutable
abstract class CollectionsHomePageState {}

class OnBlocLoad extends CollectionsHomePageState {}

class OnCollectionsLoad extends CollectionsHomePageState {
  final List<Collection> collections;

  OnCollectionsLoad(this.collections);
}

class OnPageLoading extends CollectionsHomePageState {}

class OnPageError extends CollectionsHomePageState {
  final Failure failure;

  OnPageError(this.failure);
}
