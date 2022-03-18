import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:router_experiments/auto_route/master_detail_router.dart';
import 'package:router_experiments/auto_route/routes.gr.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, @pathParam required this.index})
      : super(key: key);

  final int index;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late int _random;

  @override
  void initState() {
    super.initState();
    _random = Random().nextInt(100);
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: widget.index,
      child: _DetailsPage(widget: widget, random: _random),
    );
  }
}

class _DetailsPage extends StatelessWidget {
  const _DetailsPage({
    Key? key,
    required this.widget,
    required int random,
  })  : _random = random,
        super(key: key);

  final DetailsPage widget;
  final int _random;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Beamer.of(context).beamBack();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Details of ${widget.index}'),
            Text('Random number: $_random'),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Show Comments'),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentsPage extends StatelessWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = context.watch<int>();

    return Scaffold(
      body: Center(
        child: Center(
          child: Text('Comments for item $index'),
        ),
      ),
    );
  }
}
