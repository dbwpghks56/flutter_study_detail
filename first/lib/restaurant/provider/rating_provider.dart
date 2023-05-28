import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:first/common/provider/pagination_provider.dart';
import 'package:first/rating/model/rating_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/restaurant_rating_repository.dart';

final ratingProvider = StateNotifierProvider.family<RatingStateNotifier, CursorPaginationBase, String>
  ((ref, id) {
    final repository = ref.watch(ratingRepositoryProvider(id));

    return RatingStateNotifier(repository: repository);
} );

class RatingStateNotifier extends PaginationProvider<RatingModel, RestaurantRatingRepository>{
  RatingStateNotifier({
    required super.repository
  });
  
}