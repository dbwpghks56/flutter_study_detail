import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:first/common/model/model_with_id.dart';
import 'package:first/common/provider/pagination_provider.dart';
import 'package:first/common/utils/pagination_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
    BuildContext context, int index, T model);

class PaginationListView<T extends IModelWithId> extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase> provider;

  final PaginationWidgetBuilder<T> itemBuilder;

  const PaginationListView({required this.provider,
    required this.itemBuilder, Key? key}) : super(key: key);

  @override
  ConsumerState<PaginationListView> createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId> extends ConsumerState<PaginationListView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.addListener(listener);
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void listener() {
    PaginationUtils.paginate(
        scrollController: controller,
        provider: ref.read(widget.provider.notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    if (state is CursorPaginationLoading) {
      return Center(child: CircularProgressIndicator());
    }

    // 에러
    if(state is CursorPaginationError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0,),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.provider.notifier).paginate(
                forceRefetch: true
              );
            },
            child: Text(
              "refresh"
            ),
          )
        ],
      );
    }

    final cp = state as CursorPagination<T>;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          controller: controller,
          itemCount: cp.data.length + 1,
          itemBuilder: (_, index) {
            if(index == cp.data.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Center(
                  child: cp is CursorPaginationFetchingMore ?
                  CircularProgressIndicator() : Text("마지막 주문입니다 ㅠㅠ"),
                ),
              );
            }

            final pItem = cp.data[index];

            return widget.itemBuilder(
              context, index, pItem
            );
          },
          // 각 아이템 사이사이에 들어갈 것을 정의
          separatorBuilder: (_, index) {
            return SizedBox(height: 16.0,);
          },
        )
    );
  }
}



















