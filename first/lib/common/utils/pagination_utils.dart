import 'package:first/common/provider/pagination_provider.dart';
import 'package:flutter/cupertino.dart';

class PaginationUtils{
  static void paginate({
    required ScrollController scrollController,
    required PaginationProvider provider
  }) {
    if (scrollController.offset > scrollController.position.maxScrollExtent - 300) {
      provider.paginate(
          fetchMore: true
      );
    }
  }
}