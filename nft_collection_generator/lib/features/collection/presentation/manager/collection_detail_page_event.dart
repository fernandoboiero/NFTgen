part of 'collection_detail_page_bloc.dart';

@immutable
abstract class CollectionDetailPageEvent {}

class ActionGetCollectionDetail extends CollectionDetailPageEvent {
  final String id;

  ActionGetCollectionDetail(this.id);
}
