import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:router_experiments/auto_route/master_detail_router.dart';
import 'package:router_experiments/auto_route/routes.gr.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ItemsList());
  }
}

class ListPageWithDetails extends StatelessWidget {
  const ListPageWithDetails({Key? key}) : super(key: key);

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
          onTap: () => AutoRouter.of(context).navigateNamed('/list/$index'),
        );
      },
    );
  }
}
