import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/restaurant_rating_repository.dart';

class RatingStateNotifier extends StateNotifier<CursorPaginationBase>{
  final RestaurantRatingRepository restaurantRatingRepository;

  RatingStateNotifier({
    required this.restaurantRatingRepository
  }): super(
    CursorPaginationLoading()
  );



}