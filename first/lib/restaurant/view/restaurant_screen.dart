import 'package:dio/dio.dart';
import 'package:first/common/dio/dio.dart';
import 'package:first/restaurant/component/restaurant_card.dart';
import 'package:first/restaurant/model/restaurant_model.dart';
import 'package:first/restaurant/repository/restaurant_repository.dart';
import 'package:first/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/data.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);
  
  Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);

    final resp = await RestaurantRepository(dio, baseUrl: 'http://${ip}/restaurant').paginate();


    return resp.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List<RestaurantModel>>(
            future: paginateRestaurant(ref),
            builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
              if(!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              
              return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    final pItem = snapshot.data![index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => RestaurantDetailScreen(id: pItem.id,title: pItem.name,))
                        );
                      },
                      child: RestaurantCard.fromModel(
                          model: pItem,
                      ),
                    );
                  },
                  // 각 아이템 사이사이에 들어갈 것을 정의
                  separatorBuilder: (_, index) {
                    return SizedBox(height: 16.0,);
                  },
              );
            },
          )
        ),
      ),
    );
  }
}















