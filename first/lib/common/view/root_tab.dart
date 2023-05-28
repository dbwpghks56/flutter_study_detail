import 'package:first/common/const/colors.dart';
import 'package:first/common/layout/default_layout.dart';
import 'package:first/product/view/product_tab.dart';
import 'package:first/restaurant/view/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with
SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TabController(
      // children의 개수
        length: 4,
        vsync: this
    );
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: TabBarView(
        // 이렇게 하면 드래그로 페이지 이동이 되지 않는다.
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          RestaurantScreen(),
          ProductTab(),
          Container(
            child: Text("receip"),
          ),
          Container(
            child: Text("profile"),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        // 기본은 shifting, 선택된 것이 크기가 변하고 나머지는 라벨이 안 나온다. 당연히 fixed는 반대
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined),
              label: '음식'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              label: '주문'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: '프로필'
          ),
        ],
      ),
    );
  }
}









