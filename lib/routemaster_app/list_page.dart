import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import 'master_detail_router.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterDetailRouter(
        debugName: 'ListPageRouter',
        masterBuilder: (context) => const ItemsList(),
      ),
    );
  }
}

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item $index'),
          onTap: () {
            TabPage.of(context).controller.
          },
        );
      },
    );
  }
}
