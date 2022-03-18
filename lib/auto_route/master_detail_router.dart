import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:router_experiments/auto_route/routes.gr.dart';

class MasterDetailRouter extends StatefulWidget {
  const MasterDetailRouter({
    Key? key,
    required this.masterBuilder,
    this.debugName = '',
  }) : super(key: key);

  final WidgetBuilder masterBuilder;
  final String debugName;

  @override
  State<MasterDetailRouter> createState() => _MasterDetailRouterState();
}

class _MasterDetailRouterState extends State<MasterDetailRouter> {
  late GlobalKey<AutoRouterState> _routerKey = GlobalKey();

  bool get _hasPage {
    var hasPendingSubNavigation =
        AutoRouter.of(context).current.hasPendingChildren;

    return _routerKey.currentState?.controller?.hasEntries ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      key: _routerKey,
      builder: (context, content) {
        if (!_hasPage) {
          return widget.masterBuilder(context);
        }
        if (_showBoth(context)) {
          return Row(
            children: [
              Expanded(child: widget.masterBuilder(context)),
              Expanded(child: content),
            ],
          );
        } else {
          return content;
        }
      },
    );
  }

  bool _showBoth(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return size.width > 600;
  }
}
