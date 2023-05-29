import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NestedScreen extends StatelessWidget {
  final Widget child;
  const NestedScreen({required this.child, Key? key}) : super(key: key);

  int getIndex(BuildContext context) {
    if(GoRouterState.of(context).location == '/nested/a') {
      return 0;
    } else if (GoRouterState.of(context).location == '/nested/b') {
      return 1;
    }else {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${GoRouterState.of(context).location}"),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: getIndex(context),
        onTap: (index) {
          if(index == 0) {
            context.go("/nested/a");
          } else if(index == 1) {
            context.go("/nested/b");
          } else {
            context.go("/nested/c");
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "person"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "notifications"
          ),
        ],
      ),
    );
  }
}
