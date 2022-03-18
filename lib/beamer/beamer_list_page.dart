import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:router_experiments/beamer/beamer_master_detail.dart';
import 'package:router_experiments/beamer/details_page.dart';

class ListLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('list'),
        child: ItemsList(),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => [
        '/list',
      ];
}

class DetailsLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final id = state.pathParameters['id'];

    return [
      if (state.pathParameters.containsKey('id'))
        BeamPage(
          key: ValueKey('item-$id'),
          child: DetailsPage(index: int.parse(id!)),
        ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/list/:id'];
}

class BeamerListPage extends StatelessWidget {
  BeamerListPage({Key? key}) : super(key: key);

  final _beamerKey = GlobalKey<BeamerState>();
  final _delegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        ListLocation(),
        DetailsLocation(),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Beamer(
        key: _beamerKey,
        routerDelegate: _delegate,
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
          onTap: () => context.beamTo(DetailsLocation()),
        );
      },
    );
  }
}
