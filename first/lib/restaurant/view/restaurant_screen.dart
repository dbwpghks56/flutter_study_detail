import 'package:dio/dio.dart';
import 'package:first/restaurant/component/restaurant_card.dart';
import 'package:first/restaurant/model/restaurant_model.dart';
import 'package:first/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../common/const/data.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);
  
  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    
    final resp = await dio.get(
      'http://${ip}/restaurant',
      options: Options(
        headers: {
          'authorization': 'Bearer ${accessToken}'
        },
      )
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if(!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              
              return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    final item = snapshot.data![index];
                    final pItem = RestaurantModel.fromJson(
                      item
                    );

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















