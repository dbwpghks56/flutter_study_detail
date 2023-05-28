import 'package:first/common/model/model_with_id.dart';

import '../model/cursor_pagination_model.dart';
import '../model/pagination_params.dart';

abstract class IBasePaginationRepository<T extends IModelWithId> {

  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}