import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:router_experiments/beamer/beamer_master_detail.dart';
import 'package:router_experiments/beamer/details_page.dart';

class BeamerListPage extends StatelessWidget {
  const BeamerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BeamerMasterDetail(
        masterBuilder: (_) => const ItemsList(),
        routes: {
          '/list/:id': (_, state, ___) => DetailsPage(
                index: int.parse(
                  state.pathParameters['id']!,
                ),
              )
        },
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
          onTap: () => context.beamToNamed('/list/$index'),
        );
      },
    );
  }
}
