import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layout/default_layout.dart';

class QueryScreen extends StatelessWidget {
  const QueryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          Text(
            "query ${GoRouterState.of(context).queryParameters}"
          ),
          ElevatedButton(
            onPressed: () {
              context.push(Uri(
                path: "/query_param",
                queryParameters: {
                  "name" : "babo"
                }
              ).toString());
            },
            child: Text(
              "Query Screen"
            ),
          )
        ],
      ),
    );
  }
}
