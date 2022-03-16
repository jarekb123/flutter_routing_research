import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class BeamerMasterDetail extends StatefulWidget {
  const BeamerMasterDetail({
    Key? key,
    required this.masterBuilder,
    required this.routes,
  }) : super(key: key);

  final WidgetBuilder masterBuilder;
  final Map<Pattern, dynamic Function(BuildContext, BeamState, Object?)> routes;

  @override
  State<BeamerMasterDetail> createState() => _BeamerMasterDetailState();
}

class _BeamerMasterDetailState extends State<BeamerMasterDetail> {
  final _beamerKey = GlobalKey<BeamerState>();
  late final _delegate = BeamerDelegate(
    locationBuilder: (info, params) {
      final matched = RoutesBeamLocation.chooseRoutes(info, widget.routes.keys);

      if (matched.isNotEmpty) {
        return RoutesLocationBuilder(
          routes: widget.routes,
          builder: builder,
        )(info, params);
      } else {
        return GuardShowPage(
          info,
          BeamPage(
            child: Builder(
              builder: (context) => widget.masterBuilder(context),
            ),
          ),
        );
      }
    },
    transitionDelegate: const NoAnimationTransitionDelegate(),
  );

  bool get _hasPages => _delegate.currentPages.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Beamer(
      key: _beamerKey,
      routerDelegate: _delegate,
    );
  }

  Widget builder(BuildContext context, Widget navigator) {
    if (!_hasPages) {
      return widget.masterBuilder(context);
    } else if (_showBoth(context)) {
      return Row(
        children: [
          Expanded(child: widget.masterBuilder(context)),
          Expanded(child: navigator),
        ],
      );
    }

    return navigator;
  }

  bool _showBoth(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return size.width > 600;
  }
}
