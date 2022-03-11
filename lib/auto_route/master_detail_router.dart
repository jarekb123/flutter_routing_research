import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class MasterDetailRouter extends StatelessWidget {
  const MasterDetailRouter({
    Key? key,
    required this.masterBuilder,
  }) : super(key: key);

  final WidgetBuilder masterBuilder;

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      builder: (context, content) {
        var router = AutoRouter.of(context);
        if (router.stack.isEmpty) {
          return masterBuilder(context);
        }
        if (_showBoth(context)) {
          return Row(
            children: [
              Expanded(child: masterBuilder(context)),
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
