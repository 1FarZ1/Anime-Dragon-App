// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:anime_slayer/features/animes/presentation/logic/anime_controller.dart';

import 'logic/filter_type.dart';

class SearchOption {
  final String query;
  final FilterType filter;

  SearchOption(
   {
    required this.query,
    required this.filter,
   }
  );




  SearchOption copyWith({
    String? query,
    FilterType? filter,
  }) {
    return SearchOption(
      query: query ?? this.query,
      filter: filter ?? this.filter,
    );
  }



  @override
  String toString() => 'SearchOption(query: $query, filter: $filter)';

  @override
  bool operator ==(covariant SearchOption other) {
    if (identical(this, other)) return true;
  
    return 
      other.query == query &&
      other.filter == filter;
  }

  @override
  int get hashCode => query.hashCode ^ filter.hashCode;
}
