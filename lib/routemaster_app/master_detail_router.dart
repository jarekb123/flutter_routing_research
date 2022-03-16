import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

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
  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);
    final content = PageStackNavigator(stack: tabPage.currentStack);

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
  }

  bool _showBoth(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return size.width > 600;
  }
}
